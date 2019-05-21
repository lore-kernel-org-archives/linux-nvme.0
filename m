From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 20 May 2019 23:56:02 -0700
Subject: [PATCH RFC 0/4] nvmet: add support for port based io priority
In-Reply-To: <SN6PR04MB4527B78B40C2B1D11355FA9F860B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
 <20190517094545.GA26412@infradead.org>
 <SN6PR04MB4527B78B40C2B1D11355FA9F860B0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190521065602.GA17946@infradead.org>

On Fri, May 17, 2019@04:28:43PM +0000, Chaitanya Kulkarni wrote:
> Okay, thanks for the reply Christoph. Quick question, when you mention
> 
> "Until NVMe has an actually working priority" -> host side support for
> 
> priority based block layer request -> NVMe Request processing with
> 
> having weighted round robin priority SQ for NVMe Host  ?

Weighted round robing is _NOT_ and I/O priority - it just just changes
arbitration.  But there had been priority proposals in the working
group before, without much progress at the moment, though.
