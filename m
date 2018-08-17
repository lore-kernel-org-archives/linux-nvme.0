From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 09:10:09 +0200
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
 <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
Message-ID: <20180817071009.GB11383@lst.de>

On Tue, Aug 14, 2018@06:35:16PM -0700, Michal Wnukowski wrote:
> 
> The other side in this case is not actual controller hardware, but 
> virtual one (the regular hardware should rely on normal MMIO 
> doorbells).

There could very much be real hardware there.  We've made it clear
in the spec that while a typical use case is a virtualized controller
there is nothing peventing hardware implementations.  There have
been previous hardware prototypes to use very similar tricks, e.g.:

https://www.usenix.org/node/179878
