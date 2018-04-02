From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Apr 2018 08:21:42 -0600
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
 <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
 <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
Message-ID: <20180402142141.GC28945@localhost.localdomain>

On Mon, Apr 02, 2018@10:47:10AM -0300, Rodrigo Rosatti Galvao wrote:
> One thing that I just forgot to explain previously, but I think its
> relevant:
> 
> 1. The command is failing with 4k logical block size, but works with 512B
> 
> 2. With the patch, the command is working for both 512B and 4K.

While you're not getting errors with your patch, you're not zeroing out
the requested blocks, so that's a data corruption.

The issue is the +1 is in the wrong place. It needs to be added to the
native format prior to converting it to a 512b sector count. Do you want
to resend with that change?
