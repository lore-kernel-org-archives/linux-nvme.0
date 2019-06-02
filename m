From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 2 Jun 2019 23:03:52 +0000
Subject: [PATCH V5 1/6] nvme: Do not return in the middle of the subcommand
References: <BYAPR04MB5749C9BDCCDA22B5390ED26086020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190523145750.27425-1-minwoo.im.dev@gmail.com>
 <20190523145750.27425-2-minwoo.im.dev@gmail.com>
 <CGME20190524013628epcas4p2a5b6451a173e112a13157f193fb29321@epcms2p2>
 <20190524014037epcms2p26b77433a8c919b847ccb9f8acbb2485a@epcms2p2>
Message-ID: <BYAPR04MB574964DAEA1B94732AE1E349861B0@BYAPR04MB5749.namprd04.prod.outlook.com>

On 5/23/19 6:41 PM, Minwoo Im wrote:
> Some functions have label with an whitespace, but some don't.   I didn't
> wanted to involve those kind of clean-up things in this series.  I just made labels
> with its own function's previuos style, if there's not label, I put an whitespace
> prior to label.
>
> I was thinking that it could be cleaned-up at once later.  Do you really think that
> those kind of clean-up things are involved in this commit?

We should at least try and use the default style irrespective of the
inheriting existing style

which will trigger more cleanups. Begin said that now the question is
what is default style ?

I'd just stick to non space labels as that is something been consistent
with kernel code.

>
> Thanks for your review.
> Chaitanya,
>
