From: minwoo.im@samsung.com (Minwoo Im)
Date: Fri, 24 May 2019 10:40:37 +0900
Subject: [PATCH V5 1/6] nvme: Do not return in the middle of the subcommand
In-Reply-To: <BYAPR04MB5749C9BDCCDA22B5390ED26086020@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB5749C9BDCCDA22B5390ED26086020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190523145750.27425-1-minwoo.im.dev@gmail.com>
 <20190523145750.27425-2-minwoo.im.dev@gmail.com>
 <CGME20190524013628epcas4p2a5b6451a173e112a13157f193fb29321@epcms2p2>
Message-ID: <20190524014037epcms2p26b77433a8c919b847ccb9f8acbb2485a@epcms2p2>

Some functions have label with an whitespace, but some don't.   I didn't
wanted to involve those kind of clean-up things in this series.  I just made labels
with its own function's previuos style, if there's not label, I put an whitespace
prior to label.

I was thinking that it could be cleaned-up at once later.  Do you really think that
those kind of clean-up things are involved in this commit?

Thanks for your review.
Chaitanya,
