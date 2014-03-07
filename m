From: tj@kernel.org (Tejun Heo)
Date: Fri, 7 Mar 2014 10:26:55 -0500
Subject: [PATCH 6/9] nvme: don't use PREPARE_WORK
In-Reply-To: <1392929071-16555-7-git-send-email-tj@kernel.org>
References: <1392929071-16555-1-git-send-email-tj@kernel.org>
 <1392929071-16555-7-git-send-email-tj@kernel.org>
Message-ID: <20140307152655.GG30778@htj.dyndns.org>

On Thu, Feb 20, 2014@03:44:28PM -0500, Tejun Heo wrote:
> PREPARE_[DELAYED_]WORK() are being phased out.  They have few users
> and a nasty surprise in terms of reentrancy guarantee as workqueue
> considers work items to be different if they don't have the same work
> function.
> 
> nvme_dev->reset_work is multiplexed with multiple work functions.
> Introduce nvme_reset_workfn() which invokes nvme_dev->reset_workfn and
> always use it as the work function and update the users to set the
> ->reset_workfn field instead of overriding the work function using
> PREPARE_WORK().
> 
> It would probably be best to route this with other related updates
> through the workqueue tree.
> 
> Compile tested.
> 
> Signed-off-by: Tejun Heo <tj at kernel.org>
> Cc: Matthew Wilcox <willy at linux.intel.com>
> Cc: linux-nvme at lists.infradead.org

Applied to wq/for-3.15.  Please holler if there's any objection.

Thanks.

-- 
tejun
