From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 May 2018 08:06:30 +0200
Subject: [PATCH] nvme: allow duplicate controller if prior controller
 being deleted
In-Reply-To: <20180525210223.504-1-jsmart2021@gmail.com>
References: <20180525210223.504-1-jsmart2021@gmail.com>
Message-ID: <20180530060630.GB22380@infradead.org>

On Fri, May 25, 2018@02:02:23PM -0700, James Smart wrote:
> The current checks for whether a new controller request "matches"
> an existing controller ignores controller state and checks identity
> strings. There are cases where an existing controller may be in its
> last steps of deletion when they are "matched" by a new connection.
> 
> Change the behavior so that the new connection ignores controllers
> that are deleted.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Applied to nvme-4.18.
