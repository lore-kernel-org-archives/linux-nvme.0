From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jun 2014 11:38:48 -0600 (MDT)
Subject: [PATCHv2] NVMe: Async event request
In-Reply-To: <1403109380-12247-1-git-send-email-keith.busch@intel.com>
References: <1403109380-12247-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LRH.2.03.1406181138180.4699@AMR>

Scratch this ... it loses count on a suspend/resume or reset.

On Wed, 18 Jun 2014, Keith Busch wrote:
> Submits NVMe asynchronous event requests, one event up to the controller
> maximum or number of possible different event types (8), whichever is
> smaller. Events successfully returned by the controller are logged.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
