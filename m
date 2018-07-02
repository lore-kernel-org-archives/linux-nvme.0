From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 3 Jul 2018 00:10:06 +0800
Subject: [PATCH 1/2] nvme-pci: remove whitespace
In-Reply-To: <20180702154515.GA22877@localhost.localdomain>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
 <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>
 <20180702154515.GA22877@localhost.localdomain>
Message-ID: <CAA70yB6yyWxLg2Wi0w0YkYMpqD3QxNCeS6VSF3UKxwck=PCXSw@mail.gmail.com>

Keith Busch <keith.busch at linux.intel.com> ?2018?7?2??? ??11:46???
>
> These style changes aren't the sort of cleanups we need. For one, there's
> nothing wrong with how it already exists, and it has been this particular
> style since the driver's inclusion; there are lots of other places in
> the driver using this pattern. More importantly, it creates inconvenient
> stable porting issues for developers doing real work in these areas.
>
OK, I drop this one
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
