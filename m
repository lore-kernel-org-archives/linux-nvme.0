From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 May 2014 09:39:53 -0600 (MDT)
Subject: [PATCH] NVMe: Fix potentail NULL deferences oops
In-Reply-To: <1399562809-13986-1-git-send-email-keith.busch@intel.com>
References: <1399562809-13986-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LRH.2.03.1405080928520.5666@AMR>

WRT the subject line, I do know how to spell 'potential'. :)

On Thu, 8 May 2014, Keith Busch wrote:
> We were relying on a macro to not use a NULL pointer in a "hot remove"
> scenario, but we should not depend on this macro never to change.
