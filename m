From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Oct 2018 14:30:52 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <b3aae7aa8241c9828c04d2f2b58927f4ce1411b9.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <1540244870.128590.39.camel@acm.org>
 <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me>
 <b3aae7aa8241c9828c04d2f2b58927f4ce1411b9.camel@sipsolutions.net>
Message-ID: <b61979ff-918b-a27e-3d3b-34e9cfc23083@grimberg.me>


> 
> I also commented over there regarding this specific problem.
> 
> I think my wording was inaccurate perhaps. It's not so much direct
> recursion, but a dependency chain connecting the handler_mutex class
> back to itself. This is how lockdep finds problems, it doesn't consider
> actual *instances* but only *classes*.
> 
> As Sagi mentioned on the other thread, in this specific instance you
> happen to know out-of-band that this is safe, (somehow) the code ensures
> that you can't actually recursively connect back to yourself. Perhaps
> there's some kind of layering involved, I don't know. (*)
> 
> As I said over there, this type of thing can be solved with
> mutex_lock_nested(), though it's possible that in this case it should
> really be flush_workqueue_nested() or flush_work_nested() or so.

I guess that could make this specific complaint complaint go away...

> johannes
> 
> (*) note that just checking "obj != self" might not be enough, depending
> on how you pick candidates for "obj" you might recurse down another
> level and end up back at yourself, just two levels down, and actually
> have a dependency chain leading back to yourself.

Its not a simple check, any removal invocation is serialized under a
dedicated workqueue and in order to be queued there, the connection need
to first be connected which comes later (after the flush takes place).
