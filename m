From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 13 May 2019 09:35:24 -0700
Subject: [PATCH] nvme-core: trace discovery log change AEN
In-Reply-To: <SN6PR04MB452729CE574409342C30978F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190506193320.30884-1-chaitanya.kulkarni@wdc.com>
 <20190513132401.GA2661@infradead.org>
 <SN6PR04MB452729CE574409342C30978F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190513163524.GA32058@infradead.org>

On Mon, May 13, 2019@04:32:01PM +0000, Chaitanya Kulkarni wrote:
> > What about just moving the trace_nvme_async_event call before the
> > switch statement?
> >
> 
> That is something I avoided since for default case we don't want to 
> trace but dev_warn.
> 
> But seems like we are okay with trace and dev_warn I'll send a V2.

Doing both sounds fine and even desirable, so that we see the
invalid case in the traces as well as in the dmesg log.
