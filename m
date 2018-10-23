From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Oct 2018 17:43:51 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <1540244870.128590.39.camel@acm.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <1540244870.128590.39.camel@acm.org>
Message-ID: <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me>


>> I must also say that I'm disappointed you'd try to do things this way.
>> I'd be (have been?) willing to actually help you understand the problem
>> and add the annotations, but rather than answer my question ("where do I
>> find the right git tree"!) you just send a revert patch.
> 
> Sorry that I had not yet provided that information. You should have
> received this information through another e-mail thread. See also
> http://lists.infradead.org/pipermail/linux-nvme/2018-October/020493.html.
> 
>> To do that, you have to understand what recursion is valid (I'm guessing
>> there's some sort of layering involved), and I'm far from understanding
>> anything about the code that triggered this report.
> 
> I don't think there is any kind of recursion involved in the NVMe code
> that triggered the lockdep complaint. Sagi, please correct me if I got this
> wrong.

I commented on the original thread. I'm not sure it qualifies as a
recursion, but in that use-case, when priv->handler_mutex is taken
it is possible that other priv->handler_mutex instances are taken but
are guaranteed not to belong to that priv...
