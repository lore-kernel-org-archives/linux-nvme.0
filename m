From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Wed, 13 Feb 2019 15:07:38 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190213220923.GK4240@linux.ibm.com>
References: <20190213011023.GX4240@linux.ibm.com>
 <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com>
 <1550082964.19311.66.camel@acm.org>
 <20190213184839.GD4240@linux.ibm.com>
 <1550085136.19311.78.camel@acm.org>
 <20190213193013.GG4240@linux.ibm.com>
 <20190213195205.GA13650@linux.ibm.com>
 <1550091612.31902.48.camel@acm.org>
 <20190213220923.GK4240@linux.ibm.com>
Message-ID: <20190213230738.GA29567@linux.ibm.com>

On Wed, Feb 13, 2019@02:09:23PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 13, 2019@01:00:12PM -0800, Bart Van Assche wrote:
> > On Wed, 2019-02-13@11:52 -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 13, 2019@11:30:13AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Feb 13, 2019@11:12:16AM -0800, Bart Van Assche wrote:
> > > > > commit 4317228ad9b86f094d70c951f9210a8a9b2816be
> > > > > Author: Nitzan Carmi <nitzanc at mellanox.com>
> > > > > Date:   Mon Apr 9 17:50:26 2018 +0300
> > > > > 
> > > > >     nvme: Avoid flush dependency in delete controller flow
> > > > >      
> > > > >     The nvme_delete_ctrl() function queues a work item on a MEM_RECLAIM
> > > > >     queue (nvme_delete_wq), which eventually calls cleanup_srcu_struct(),
> > > > >     which in turn flushes a delayed work from an !MEM_RECLAIM queue. This
> > > > >     is unsafe as we might trigger deadlocks under severe memory pressure.
> > > 
> > > Except that RCU's workqueues have since been set up as WQ_MEM_RECLAIM.
> > > 
> > > So could you please try switching back to cleanup_srcu_struct()?
> > 
> > (just back from lunch)
> > 
> > Hi Paul,
> > 
> > That change is sufficient to get rid of the KASAN use-after-free complaint.
> > Do you want to submit a patch or do you expect me to do that? If I have to
> > prepare a patch I think it will take a significant effort to come up with a
> > good patch description.
> 
> How about the following untested patch?  (Starting tests now.)

And this passes light rcutorture testing.  I will run somewhat more
extensive tests overnight (Pacific Time).

								Thanx, Paul

> ------------------------------------------------------------------------
> 
> commit 65f1b53aeb25a9bddabd08e37bb4c7246320f993
> Author: Paul E. McKenney <paulmck at linux.ibm.com>
> Date:   Wed Feb 13 13:54:37 2019 -0800
> 
>     srcu: Remove cleanup_srcu_struct_quiesced()
>     
>     The cleanup_srcu_struct_quiesced() function was added because NVME
>     used WQ_MEM_RECLAIM workqueues and SRCU did not, which meant that
>     NVME workqueues waiting on SRCU workqueues could result in deadlocks
>     during low-memory conditions.  However, SRCU now also has WQ_MEM_RECLAIM
>     workqueues, so there is no longer a potential for deadlock.  Furthermore,
>     it turns out to be extremely hard to use cleanup_srcu_struct_quiesced()
>     correctly due to the fact that SRCU callback invocation accesses the
>     srcu_struct structure's per-CPU data area just after callbacks are
>     invoked.  Therefore, the usual practice of using srcu_barrier() to wait
>     for callbacks to be invoked before invoking cleanup_srcu_struct_quiesced()
>     fails because SRCU's callback-invocation workqueue handler might be
>     delayed, which can result in cleanup_srcu_struct_quiesced() being invoked
>     (and thus freeing the per-CPU data) before the SRCU's callback-invocation
>     workqueue handler is finished using that per-CPU data.  Nor is this a
>     theoretical problem: KASAN emitted use-after-free warnings because of
>     this problem on actual runs.
>     
>     In short, NVME can now safely invoke cleanup_srcu_struct(), which
>     avoids the use-after-free scenario.  And cleanup_srcu_struct_quiesced()
>     is quite difficult to use safely.  This commit therefore removes
>     cleanup_srcu_struct_quiesced(), switching its sole user back to
>     cleanup_srcu_struct().  This effectively reverts the following pair
>     of commits:
>     
>     f7194ac32ca2 ("srcu: Add cleanup_srcu_struct_quiesced()")
>     4317228ad9b8 ("nvme: Avoid flush dependency in delete controller flow")
>     
>     Reported-by: Bart Van Assche <bvanassche at acm.org>
>     Signed-off-by: Paul E. McKenney <paulmck at linux.ibm.com>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 150e49723c15..72ca25c8cc41 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -391,7 +391,7 @@ static void nvme_free_ns_head(struct kref *ref)
>  	nvme_mpath_remove_disk(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	list_del_init(&head->entry);
> -	cleanup_srcu_struct_quiesced(&head->srcu);
> +	cleanup_srcu_struct(&head->srcu);
>  	nvme_put_subsystem(head->subsys);
>  	kfree(head);
>  }
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index c495b2d51569..e432cc92c73d 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -56,45 +56,11 @@ struct srcu_struct { };
>  
>  void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
>  		void (*func)(struct rcu_head *head));
> -void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced);
> +void cleanup_srcu_struct(struct srcu_struct *ssp);
>  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
>  void synchronize_srcu(struct srcu_struct *ssp);
>  
> -/**
> - * cleanup_srcu_struct - deconstruct a sleep-RCU structure
> - * @ssp: structure to clean up.
> - *
> - * Must invoke this after you are finished using a given srcu_struct that
> - * was initialized via init_srcu_struct(), else you leak memory.
> - */
> -static inline void cleanup_srcu_struct(struct srcu_struct *ssp)
> -{
> -	_cleanup_srcu_struct(ssp, false);
> -}
> -
> -/**
> - * cleanup_srcu_struct_quiesced - deconstruct a quiesced sleep-RCU structure
> - * @ssp: structure to clean up.
> - *
> - * Must invoke this after you are finished using a given srcu_struct that
> - * was initialized via init_srcu_struct(), else you leak memory.  Also,
> - * all grace-period processing must have completed.
> - *
> - * "Completed" means that the last synchronize_srcu() and
> - * synchronize_srcu_expedited() calls must have returned before the call
> - * to cleanup_srcu_struct_quiesced().  It also means that the callback
> - * from the last call_srcu() must have been invoked before the call to
> - * cleanup_srcu_struct_quiesced(), but you can use srcu_barrier() to help
> - * with this last.  Violating these rules will get you a WARN_ON() splat
> - * (with high probability, anyway), and will also cause the srcu_struct
> - * to be leaked.
> - */
> -static inline void cleanup_srcu_struct_quiesced(struct srcu_struct *ssp)
> -{
> -	_cleanup_srcu_struct(ssp, true);
> -}
> -
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
>  /**
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index f14d1b18a74f..d2b226110835 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -592,12 +592,7 @@ static void srcu_torture_init(void)
>  
>  static void srcu_torture_cleanup(void)
>  {
> -	static DEFINE_TORTURE_RANDOM(rand);
> -
> -	if (torture_random(&rand) & 0x800)
> -		cleanup_srcu_struct(&srcu_ctld);
> -	else
> -		cleanup_srcu_struct_quiesced(&srcu_ctld);
> +	cleanup_srcu_struct(&srcu_ctld);
>  	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
>  }
>  
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 5d4a39a6505a..44d6606b8325 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -76,19 +76,16 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
>   * Must invoke this after you are finished using a given srcu_struct that
>   * was initialized via init_srcu_struct(), else you leak memory.
>   */
> -void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> +void cleanup_srcu_struct(struct srcu_struct *ssp)
>  {
>  	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
> -	if (quiesced)
> -		WARN_ON(work_pending(&ssp->srcu_work));
> -	else
> -		flush_work(&ssp->srcu_work);
> +	flush_work(&ssp->srcu_work);
>  	WARN_ON(ssp->srcu_gp_running);
>  	WARN_ON(ssp->srcu_gp_waiting);
>  	WARN_ON(ssp->srcu_cb_head);
>  	WARN_ON(&ssp->srcu_cb_head != ssp->srcu_cb_tail);
>  }
> -EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
> +EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>  
>  /*
>   * Removes the count for the old reader from the appropriate element of
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 4f30f3ecabc1..9b761e546de8 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -360,8 +360,14 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>  	return SRCU_INTERVAL;
>  }
>  
> -/* Helper for cleanup_srcu_struct() and cleanup_srcu_struct_quiesced(). */
> -void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
> +/**
> + * cleanup_srcu_struct - deconstruct a sleep-RCU structure
> + * @ssp: structure to clean up.
> + *
> + * Must invoke this after you are finished using a given srcu_struct that
> + * was initialized via init_srcu_struct(), else you leak memory.
> + */
> +void cleanup_srcu_struct(struct srcu_struct *ssp)
>  {
>  	int cpu;
>  
> @@ -369,24 +375,12 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
>  		return; /* Just leak it! */
>  	if (WARN_ON(srcu_readers_active(ssp)))
>  		return; /* Just leak it! */
> -	if (quiesced) {
> -		if (WARN_ON(delayed_work_pending(&ssp->work)))
> -			return; /* Just leak it! */
> -	} else {
> -		flush_delayed_work(&ssp->work);
> -	}
> +	flush_delayed_work(&ssp->work);
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		if (quiesced) {
> -			if (WARN_ON(timer_pending(&sdp->delay_work)))
> -				return; /* Just leak it! */
> -			if (WARN_ON(work_pending(&sdp->work)))
> -				return; /* Just leak it! */
> -		} else {
> -			del_timer_sync(&sdp->delay_work);
> -			flush_work(&sdp->work);
> -		}
> +		del_timer_sync(&sdp->delay_work);
> +		flush_work(&sdp->work);
>  		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>  			return; /* Forgot srcu_barrier(), so just leak it! */
>  	}
> @@ -399,7 +393,7 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
>  	free_percpu(ssp->sda);
>  	ssp->sda = NULL;
>  }
> -EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
> +EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>  
>  /*
>   * Counts the new reader in the appropriate per-CPU element of the
