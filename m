From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 02 Oct 2018 08:02:17 -0700
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <d6b9397c-2817-535d-f794-74dc01d8f601@grimberg.me>
References: <20180927180031.10706-1-sagi@grimberg.me>
 <1538172846.53591.8.camel@acm.org>
 <d6b9397c-2817-535d-f794-74dc01d8f601@grimberg.me>
Message-ID: <1538492537.193396.1.camel@acm.org>

On Mon, 2018-10-01@13:12 -0700, Sagi Grimberg wrote:
> > > Queue deletion is done asynchronous when the last reference on
> > > the queue is dropped. Thus, in order to make sure we don't over
> > > allocate under a connect/disconnect storm, we let queue deletion
> > > complete before making forward progress.
> > > 
> > > However, given that we flush the system_wq from rdma_cm context
> > > which runs from a workqueue context, we can have a circular
> > > locking complaint [1]. Fix that by using a private workqueue for
> > > queue deletion.
> > 
> > Hi Sagi,
> > 
> > Thanks for this patch. With this patch applied the warning I reported
> > earlier disappears but a new warning appeared:
> 
> Thanks for testing, this is a similar complaint though...
> 
> What I'm missing here is why flushing a work that runs on workqueue A
> can't be done from a work that runs on workqueue B. It is
> guaranteed that the id_priv that is used as a barrier from
> rdma_destroy_id is different from the id_priv that is handling the
> connect. So I'm not clear on what is the dependency yet.
> 
> Any insights?

Hi Sagi,

Further testing showed that the warning shown in my previous e-mail also
occurs without your patch. Since I'm fine with your patch, feel free to add:

Tested-by: Bart Van Assche <bvanassche at acm.org>
