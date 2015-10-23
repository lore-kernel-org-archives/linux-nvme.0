From: hch@lst.de (Christoph Hellwig)
Date: Fri, 23 Oct 2015 07:41:44 +0200
Subject: [PATCH 17/18] nvme: move namespace scanning to common code
In-Reply-To: <20151022212424.GG21840@localhost.localdomain>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-18-git-send-email-hch@lst.de>
 <1445470059.3307.85.camel@linux.intel.com> <20151022073940.GD20076@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93CD26AE0@fmsmsx104.amr.corp.intel.com>
 <20151022163000.GB20934@lst.de>
 <20151022212424.GG21840@localhost.localdomain>
Message-ID: <20151023054144.GA30535@lst.de>

On Thu, Oct 22, 2015@09:24:25PM +0000, Busch, Keith wrote:
> It does fall through to the older way if identify list fails. My concern
> is when it doesn't fail when it should have. Some controllers claim 1.1 or
> higher, but do not interpret the Identify Namespace List correctly. They
> just check that CNS != 0, and if true, returns success with an Identify
> Namespace structure, so the driver misinterprets the data.
> 
> I filed bugs with the vendors I know about, but there may be others I
> haven't tested.

Can you blacklist the known bad controller using the quirks mechanism
I added during the driver split?
