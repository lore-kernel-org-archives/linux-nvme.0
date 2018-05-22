From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 22 May 2018 11:47:28 +0800
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <34ba4583-25be-acf7-8407-755e920def6b@kernel.dk>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
 <34ba4583-25be-acf7-8407-755e920def6b@kernel.dk>
Message-ID: <20180522034727.GE20430@ming.t460p>

On Mon, May 21, 2018@09:16:33PM -0600, Jens Axboe wrote:
> On 5/21/18 8:49 PM, Ming Lei wrote:
> > On Mon, May 21, 2018@05:11:31PM -0600, Keith Busch wrote:
> >> This patch simplifies the timeout handling by relying on the request
> >> reference counting to ensure the iterator is operating on an inflight
> > 
> > The reference counting isn't free, what is the real benefit in this way?
> 
> Neither is the current scheme and locking, and this is a hell of a lot
> simpler. I'd get rid of the kref stuff and just do a simple
> atomic_dec_and_test(). Most of the time we should be uncontended on
> that, which would make it pretty darn cheap. I'd be surprised if it
> wasn't better than the current alternatives.

The explicit memory barriers by atomic_dec_and_test() isn't free.

Also the double completion issue need to be fixed before discussing
this approach further.


Thanks,
Ming
