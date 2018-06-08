From: hare@suse.de (Hannes Reinecke)
Date: Fri, 8 Jun 2018 07:53:13 +0200
Subject: [PATCH] blktrace: display failfast and driver-specific flags
In-Reply-To: <20180607112423.GB10742@lst.de>
References: <20180607083009.41793-1-hare@suse.de>
 <20180607112423.GB10742@lst.de>
Message-ID: <20180608075313.1881dc6e@pentland.suse.de>

On Thu, 7 Jun 2018 13:24:23 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Good idea to display the flags, but the characters aren't really
> very self-describing.  Should we prefix each with an f maybe?

Honestly, I don't care.
Just wanted to stick with the one-letter acronym like all the others
did.
But in the end having the failfast ones prefixed with an 'f' sounds
reasonable.

Cheers,

Hannes
