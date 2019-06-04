From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 5 Jun 2019 00:20:43 +0900
Subject: [PATCH V5 1/6] nvme: Do not return in the middle of the subcommand
In-Reply-To: <BYAPR04MB574964DAEA1B94732AE1E349861B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB5749C9BDCCDA22B5390ED26086020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190523145750.27425-1-minwoo.im.dev@gmail.com>
 <20190523145750.27425-2-minwoo.im.dev@gmail.com>
 <CGME20190524013628epcas4p2a5b6451a173e112a13157f193fb29321@epcms2p2>
 <20190524014037epcms2p26b77433a8c919b847ccb9f8acbb2485a@epcms2p2>
 <BYAPR04MB574964DAEA1B94732AE1E349861B0@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <20190604152043.GA20696@minwooim-desktop>

On 19-06-02 23:03:52, Chaitanya Kulkarni wrote:
> On 5/23/19 6:41 PM, Minwoo Im wrote:
> > Some functions have label with an whitespace, but some don't.   I didn't
> > wanted to involve those kind of clean-up things in this series.  I just made labels
> > with its own function's previuos style, if there's not label, I put an whitespace
> > prior to label.
> >
> > I was thinking that it could be cleaned-up at once later.  Do you really think that
> > those kind of clean-up things are involved in this commit?
> 
> We should at least try and use the default style irrespective of the
> inheriting existing style
> 
> which will trigger more cleanups. Begin said that now the question is
> what is default style ?
> 
> I'd just stick to non space labels as that is something been consistent
> with kernel code.

Hmm... Actually I just tried to do all the added "ret" labels with
non-whitespace in front of it.  But it seems that it's not looking good
though because it just follows the existing style in each functions.
The new label which has been added without any exsiting labels in that
function are good to be updated into default(?) style.

In commit point of view, if a single label breaks the existing labels
style in that function might make the function dirty at the time of
commit.

I would prefer to follow the existing function's style, and for the case
of new label in a function, it will follow the default sytle which is
non-space label.

Inconsistency among the functions are not good, of course.  It should be
cleaned-up later, I guess.

Thanks,
