From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 9 May 2015 09:00:26 -0700
Subject: [PATCH v3 2/7] block: add REQ_NVM_GC for targets gc
In-Reply-To: <1429712816-10336-3-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
 <1429712816-10336-3-git-send-email-m@bjorling.me>
Message-ID: <20150509160026.GB16058@infradead.org>

On Wed, Apr 22, 2015@04:26:51PM +0200, Matias Bj??rling wrote:
> In preparation for Open-Channel SSDs. We introduce a special request for
> open-channel ssd targets that must perform garbage collection.
> 
> Requests are divided into two types. The user and target specific. User
> IOs are from fs, user-space, etc. While target specific are IOs that are
> issued in the background by targets. Usually garbage collection actions.
> 
> For the target to issue garbage collection requests, it is a requirement
> that a logical address is locked over two requests. One read and one
> write. If a write to the logical address comes in from user-space, a
> race-condition might occur and garbage collection will write out-dated
> data.
> 
> By introducing this flag, the target can manually control locking of
> logical addresses.

Seems like this should be a new ->cmd_type instead of a flag.
