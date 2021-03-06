//+------------------------------------------------------------------+
//|                                                      feeling.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      ""
#property version   "1.00"
#property strict

int tickets[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      //test();
      double ema15 = iMA(NULL, 0, 15, 0, MODE_EMA, PRICE_CLOSE, 1);
      double ema60 = iMA(NULL, 0, 60, 0, MODE_EMA, PRICE_CLOSE, 1);
      int total=OrdersTotal();
      double _min = MarketInfo(Symbol(),MODE_STOPLEVEL)/MathPow(10.0, (Digits-1)*1.0);
      double sl = 0.0;
      double tp = 0.0;
      double p = 0.0;
      if(total<=0)
        {
         if(ema15 > ema60 && (MathAbs(Low[0]-ema15)>MathAbs(ema15-ema60))) // short
           {
            if( Close[2] > Open[2] && Close[1] < Open[1] && Close[1] < Open[2])
              {
               sl = NormalizeDouble(High[1], Digits);
               p = NormalizeDouble(Bid, Digits);
               OrderSend(Symbol(), OP_SELL, 0.01, p,0, sl , 0, NULL, 0, 0, clrGreen);  
              }
            }
         if(ema15 < ema60 && (MathAbs(High[0]-ema15)>MathAbs(ema15-ema60)))
           {
            if( Close[2] < Open[2] && Close[1] > Open[1] && Close[1] > Open[2])
              {
               sl = NormalizeDouble(Low[1], Digits);
               p = NormalizeDouble(Ask, Digits);
               OrderSend(Symbol(), OP_BUY, 0.01, p,0, sl, 0,NULL, 0, 0, clrRed);
              }
           }       
        }
       else
         {
           for(int pos=0;pos<total;pos++) 
             { 
              OrderSelect(pos,SELECT_BY_POS)
              
              
                         if(OrderType() == 0)
             {
              if(MathAbs(OrderOpenPrice()-Bid)>=5/MathPow(10.0, (Digits-1)*1.0))
                {
                 OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), 3, clrRed);
                }
             }
            if(OrderType() == 1)
              {
               if(MathAbs(OrderOpenPrice()-Ask)>=5/MathPow(10.0, (Digits-1)*1.0))
               {
                 OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), 3, clrRed);
               }
              }
             } 


         }
  }
  

  
void test()
   {
Print(MarketInfo(Symbol(),MODE_TICKSIZE)); 
   //Print(MarketInfo(Symbol(),MODE_TICKSIZE));  

   }
//+------------------------------------------------------------------+
