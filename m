From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 25 Nov 2018 02:52:04 -0800
Subject: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
In-Reply-To: <20181117214354.822-3-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
Message-ID: <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>

> We currently only really support sync poll, ie poll with 1
> IO in flight. This prepares us for supporting async poll.

Hey Jens,

So are we sure that this is fine to simply replace the
poll functionality? you say that that we support poll
with only 1 I/O inflight but is it entirely true?
semantically speaking?

The interface is selective polling, which means that
the user can have more than a single I/O inflight but wants
to poll for a specific one that it really cares about.

Would this introduce a regression for users that rely
on preadv2 to basically "complete *this* IO as fast as possible"?

Note that I like the proposed direction, I'm merely questioning
if it is OK to simply change how selective polling worked until
today instead of introducing a separate blk_poll_all(q) (but with
a better name) which would be wired up to aio polling and friends.
