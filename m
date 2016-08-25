From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 25 Aug 2016 17:05:02 -0500
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
In-Reply-To: <37faecd4-6b95-6a7e-69d1-f3eb712ecf54@grimberg.me>
References: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>
 <b93e8bc6-1fd1-3191-d811-1503cc2e4499@grimberg.me>
 <a004bd27-6efd-98aa-6430-da7aeafd46b0@grimberg.me>
 <37faecd4-6b95-6a7e-69d1-f3eb712ecf54@grimberg.me>
Message-ID: <023501d1ff1c$ba7daa60$2f78ff20$@opengridcomputing.com>

> > I think I suspect what is going on...
> >
> > When we get a surprise disconnect from the target we queue
> > a periodic reconnect (which is the sane thing to do...).
> >
> > We only move the queues out of CONNECTED when we retry
> > to reconnect (after 10 seconds in the default case) but we stop
> > the blk queues immediately so we are not bothered with traffic from
> > now on. If delete() is kicking off in this period the queues are still
> > in CONNECTED state.
> >
> > Part of the delete sequence is trying to issue ctrl shutdown if the
> > admin queue is CONNECTED (which it is!). This request is issued but
> > stuck in blk-mq waiting for the queues to start again. This might
> > be the one preventing us from forward progress...
> >
> > Steve, care to check if the below patch makes things better?
> >
> > The patch tries to separate the queue flags to CONNECTED and
> > DELETING. Now we will move out of CONNECTED as soon as error recovery
> > kicks in (before stopping the queues) and DELETING is on when
> > we start the queue deletion.
> 
> Steve, did you get around to have a look at this?
> 
> I managed to reproduce this on my setup and the patch
> makes it go away...

Yes, I think it is needed.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>

Thanks!!

Steve.
