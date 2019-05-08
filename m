From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 May 2019 09:23:01 +0200
Subject: [PATCH 1/2] nvme: Introduce nvme_is_fabrics to check fabrics cmd
In-Reply-To: <20190506225938epcms2p357314dad168e5822fa4145e7873f5709@epcms2p3>
References: <SN6PR04MB452746C95169477C3DD9C8A786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-2-minwoo.im.dev@gmail.com>
 <CGME20190506224156epcas4p4e0dbe316e46fc76f4e36f5f23bd61cf1@epcms2p3>
 <20190506225938epcms2p357314dad168e5822fa4145e7873f5709@epcms2p3>
Message-ID: <20190508072301.GC21823@lst.de>

On Tue, May 07, 2019@07:59:38AM +0900, Minwoo Im wrote:
> Chaitanya,
> 
> Thanks for your kindly review on this.
> 
> > I'm not sure if we need change right now, reason :-
> > 
> > Existing code is pretty straight forward and we are not having
> 
> Yeah, the code looks readable.  But I thought it would be nicer if
> it can be removed to reduce duplications in code.
> 
> > any complicated logic in the helper function. I'll let the
> 
> In fact, this is why I have introduced an inline function here.  If it
> has complicated logic inside, I would not introduce it. :)

I think I'm ok with this check.  We keep growing a few more of those,
so a little helper like this might be useful.
