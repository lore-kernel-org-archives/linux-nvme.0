From: bdeyal@gmail.com (Eyal BenDavid)
Date: Thu, 31 Jan 2019 20:08:18 +0200
Subject: Question about ioctl interface - IO passthru
In-Reply-To: <20190131145539.GB19637@localhost.localdomain>
References: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>
 <20190131145539.GB19637@localhost.localdomain>
Message-ID: <CAPrnrPCgxrucTYZeS3+7Ww7gAQmXA0JY0CB6gJXtSSAoT24D4w@mail.gmail.com>

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
