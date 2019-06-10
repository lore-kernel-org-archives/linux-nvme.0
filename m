From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 10 Jun 2019 09:51:56 +0800
Subject: [PATCH 2/3] nvme-pci: remove queue_count_ops for write,poll_queues
In-Reply-To: <20190608180219.17523-3-minwoo.im.dev@gmail.com>
References: <20190608180219.17523-1-minwoo.im.dev@gmail.com>
 <20190608180219.17523-3-minwoo.im.dev@gmail.com>
Message-ID: <20190610015155.GD26551@ming.t460p>

On Sun, Jun 09, 2019@03:02:18AM +0900, Minwoo Im wrote:
> queue_count_set() seems like that it has been provided to limit the
> number of queue entries for write/poll queues.  But, the
> queue_count_set() has been doing nothing but a parameter check even it
> has num_possible_cpus() which is nop.

However, the check is valid, which shouldn't be nop, so could you fix
the check instead of removing it?

Thanks,
Ming
