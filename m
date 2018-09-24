From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Sep 2018 21:06:20 -0700
Subject: [PATCH] Added NVMe MP failover policy.user can configure failover
 progression time. it don't have any conflict with ANA. it's a simple
 failover
 policy that will tell multipather how long it should wait before sending
 command to next available path
In-Reply-To: <20180923214524.16053-1-susobhan.dey@gmail.com>
References: <20180923214524.16053-1-susobhan.dey@gmail.com>
Message-ID: <f7534931-eb78-aa7c-6ede-a617d8258e37@grimberg.me>

Hi Susobhan,

Please fix split your change log to a title and body.

Please explain what is this trying to achieve instead of
mentioning "it don't have any conflict with ANA".

What is the point in delaying failover if we have a different
path available?

You are also adding an atomic operation to the hot path for
a questionable rational.

In a different note, I suggest we stop adding bit flags for namespace
states.

And modparam is not the way to go here at all.
