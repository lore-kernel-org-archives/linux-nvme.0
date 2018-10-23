From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 23 Oct 2018 21:50:32 +0200
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>
 (sfid-20181023_031737_471584_691D2EF3)
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
 <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>
 (sfid-20181023_031737_471584_691D2EF3)
Message-ID: <dc47992cfd3300884aab8885caebe1072ddd6c71.camel@sipsolutions.net>

On Mon, 2018-10-22@18:17 -0700, Bart Van Assche wrote:

> It seems to me that the inode lock has been annotated correctly as an 
> rwsem. It's not clear to me however why lockdep complains about a 
> deadlock for the direct I/O code. I hope someone has the time to go to 
> the bottom of this.

I think the explanation I just sent should help clarify this.

The reason for the report is that with the workqueue annotations, we've
added new links to the chains that lockdep sees. I _think_ those
annotations are correct and only create links in the chain when they are
actually present, but since those links are between *classes* not
*instances* these new links may cause false positives.

I don't think the issue is the annotations of the inode lock per se, but
that the new links in the class chain cause these locks to cycle back to
themselves, which indicates a potential deadlock to lockdep.

Of course now we need to go in and tell lockdep that it shouldn't
consider these classes the same, but somebody who actually understands
why it's _fine_ that this ends up linking back to itself should do that.
I'm willing to help, but I'd have to have somebody on the phone who
knows about all these locks and workqueues and how they interact to be
able to do something useful.

Like I said in the other email though, I don't think arbitrarily
removing links from the lockdep chain is the right thing to do. Why
arbitrarily? Well, you might just as well remove the inode sem
annotations, and that would also break the chain, right? Yes, those have
been present longer, but for this particular instance it'd be
equivalent, you'd just get different reports in other places than if you
remove the workqueue annotations again.

johannes
