From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 05 Apr 2016 09:32:49 +0200
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
Message-ID: <358c7328f56ff98bb1746cdc5a81ff3c@suse.de>

On 2016-04-05 00:24, Keith Busch wrote:
> Multiple users have reported device initialization failure on some
> platforms due the driver not receiving expected interrupts. This is not
> the fault of any particular controller. This patch polls for 
> completions
> on the admin queue in the watchdog timer, and starts the timer 
> immediately
> after controller initialization completes, just before the first admin
> command is issued.
> 
> Reported-by: Tim Muhlemmer <muhlemmer at gmail.com>
> Reported-by: Jon Derrick <jonathan.derrick at intel.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
