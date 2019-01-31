From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 31 Jan 2019 18:39:28 +0000
Subject: Question about ioctl interface - IO passthru
In-Reply-To: <CAPrnrPCgxrucTYZeS3+7Ww7gAQmXA0JY0CB6gJXtSSAoT24D4w@mail.gmail.com>
References: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>
 <20190131145539.GB19637@localhost.localdomain>,
 <CAPrnrPCgxrucTYZeS3+7Ww7gAQmXA0JY0CB6gJXtSSAoT24D4w@mail.gmail.com>
Message-ID: <BYAPR04MB4502BAB173C20E8B499D633986910@BYAPR04MB4502.namprd04.prod.outlook.com>

One of the issue with the current nvme_user_io structure is that the new commands
such as NVMe Zone append?which returns result will not be able to use the nvme_user_io
since it lacks?that field (e.g. result field) and had to use the passthru?command or add a new
command definition.

So I think it is a good start that to use the nvme_passthru command and make it more generic.

Keith any comments on this ?

or should we extend the nvme_user_io command with
the new addition such as result field (less likely in my?opinion, may break IOCTL)??

From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Eyal BenDavid <bdeyal@gmail.com>
Sent: Thursday, January 31, 2019 10:08 AM
To: Keith Busch
Cc: linux-nvme
Subject: Re: Question about ioctl interface - IO passthru
?
On Thu, Jan 31, 2019@4:56 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Thu, Jan 31, 2019@04:09:18PM +0200, Eyal BenDavid wrote:
> > What is the difference from using "nvme_user_io" structure?
> > Is it safe to use this version of IO commands?
>
> The passthru structure is good to use for any command. The
> nvme_user_io structure is a legacy feature from very early nvme days
> when read/write/compare were the only IO commands. It didn't extend to
> other IO commands, and deprecating it wouldn't be a bad thing.

Thanks!

A good start is to rewrite nvme read/write/compare commands using the
passthru structure instead of nvme_user_io.

---
Eyal

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
