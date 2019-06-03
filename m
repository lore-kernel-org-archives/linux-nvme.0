From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 03 Jun 2019 13:34:14 +0900
Subject: [PATCH V5 1/6] nvme: Do not return in the middle of the subcommand
In-Reply-To: <BYAPR04MB574964DAEA1B94732AE1E349861B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB574964DAEA1B94732AE1E349861B0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749C9BDCCDA22B5390ED26086020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190523145750.27425-1-minwoo.im.dev@gmail.com>
 <20190523145750.27425-2-minwoo.im.dev@gmail.com>
 <20190524014037epcms2p26b77433a8c919b847ccb9f8acbb2485a@epcms2p2>
 <CGME20190524013628epcas4p2a5b6451a173e112a13157f193fb29321@epcms2p3>
Message-ID: <20190603043414epcms2p30dfc8251c2d56070d94bb55c1a93a7ec@epcms2p3>

> We should at least try and use the default style irrespective of the
> inheriting existing style
> 
> which will trigger more cleanups. Begin said that now the question is
> what is default style ?

Actually, I wanted to ask what the default style is to myself  ;).

> I'd just stick to non space labels as that is something been consistent
> with kernel code.

I think following kernel code style would be better than what these
patches are doing here.

Will prepare V6 series with it.

Thanks,
