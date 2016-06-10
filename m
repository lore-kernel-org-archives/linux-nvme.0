From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 16:14:08 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <CAF1ivSbeoZtOwHfw6Arrv5oJn=uvcc=TgbB1Ny4joHDKzK_73w@mail.gmail.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
 <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>
 <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
 <01c601d1c32a$59576ec0$0c064c40$@opengridcomputing.com>
 <020b01d1c334$45077f50$cf167df0$@opengridcomputing.com>
 <CAF1ivSb82yM94jande+kfomG3hx6PwbUAzTb3VPNygd05uVbXg@mail.gmail.com>
 <023d01d1c34c$b9249bd0$2b6dd370$@opengridcomputing.com>
 <CAF1ivSb5GoBmX+5oi5d62GgJNmjzFACSx_oWdteSnmYKA2NKBQ@mail.gmail.com>
 <024201d1c354$db2e0330$918a0990$@opengridcomputing.com>
 <CAF1ivSbeoZtOwHfw6Arrv5oJn=uvcc=TgbB1Ny4joHDKzK_73w@mail.gmail.com>
Message-ID: <027901d1c35d$07150d10$153f2730$@opengridcomputing.com>

> 
> Does Sagi's patch help?
> 
> Author: Sagi Grimberg <sagi at grimberg.me>
> Date:   Thu Jun 9 13:20:09 2016 -0700
> 
>     fabrics: Don't directly free opts->host
> 
>     It might be the default host, so we need to call
>     nvmet_put_host (which is safe against NULL lucky for
>     us).
> 
>     Reported-by: Alexander Nezhinsky <alexander.nezhinsky at excelero.com>
>     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 

Yes!  Failures recover and subsequent connects work! 

Thanks for the help Ming!  Sorry I'm finding already fixed problems. :(  
