From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Dec 2018 18:14:41 -0800
Subject: [PATCH] nvme-fc: flush err and connect work in .stop_ctrl
In-Reply-To: <643654d7-2863-74f5-63d8-41aac14291d1@broadcom.com>
References: <20181220190420.23515-1-sagi@grimberg.me>
 <643654d7-2863-74f5-63d8-41aac14291d1@broadcom.com>
Message-ID: <86e7b4a6-be6e-a5c4-e490-6afa257f22c9@grimberg.me>


> Hmm... I don't remember it being described that way when it was added 
> and when I looked at it then, I had no need for the entrypoint. if all 
> it does is cancel err_work and connect_work, I'm still wondering what it 
> really does/achieves. Killing them off seems weird.
> 
> I'll take a closer look at where things sit now.

I'm fine with killing those as well.

In fact, if we move err_work and connect_work to nvme_ctrl
we can simply have nvme_stop_ctrl flush them... However Christoph
asked for a more generic use of these members/routines for that
to happen...
