From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 22:36:17 +0900
Subject: [PATCH v2 07/10] nvme-cli: Add routine to search for controller
 with specific attributes
In-Reply-To: <f020727d-28c9-ff5b-3caa-f4258284bdec@grimberg.me>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-8-jsmart2021@gmail.com>
 <20190720082504.GG22395@minwoo-desktop>
 <f020727d-28c9-ff5b-3caa-f4258284bdec@grimberg.me>
Message-ID: <20190723133617.GC7148@minwoo-desktop>

On 19-07-22 15:41:08, Sagi Grimberg wrote:
> 
> > James,
> > 
> > It might be too late to discuss about this argument, but did you decided
> > to have (struct connect_args) as a parameter for this function?
> > 
> > Sorry for not giving any thoughts on the following mail[1], but I would
> > prefer not introducing a new data structure for this because it's just a
> > bypass argument from a perspective of find_ctrl_with_connetargs().  But
> > If you think it's okay to go with, then I'm fine with that too.
> 
> I think its just fine with the connect_args. This can also extend to
> other search/match functionality we may need in the future (that is
> insensitive to short/long args).

Agreed.  I think it's good to go with what James just got sent.

Thanks for the clarification, Sagi!
