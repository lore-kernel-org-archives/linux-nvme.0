From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Sep 2016 11:38:39 -0400
Subject: [PATCH v3 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <6d237c11f22f03365789682484755b84eb6b4493.1474002926.git.luto@kernel.org>
References: <cover.1474002926.git.luto@kernel.org>
 <6d237c11f22f03365789682484755b84eb6b4493.1474002926.git.luto@kernel.org>
Message-ID: <20160916153839.GA32151@localhost.localdomain>

On Thu, Sep 15, 2016@10:24:21PM -0700, Andy Lutomirski wrote:
> NVMe devices can advertise multiple power states.  These states can
> be either "operational" (the device is fully functional but possibly
> slow) or "non-operational" (the device is asleep until woken up).
> Some devices can automatically enter a non-operational state when
> idle for a specified amount of time and then automatically wake back
> up when needed.
> 
> The hardware configuration is a table.  For each state, an entry in
> the table indicates the next deeper non-operational state, if any,
> to autonomously transition to and the idle time required before
> transitioning.
> 
> This patch teaches the driver to program APST so that each
> successive non-operational state will be entered after an idle time
> equal to 100% of the total latency (entry plus exit) associated with
> that state.  A sysfs attribute 'ps_max_latency_us' gives the maximum
> acceptable latency in ns; non-operational states with total latency
> greater than this value will not be used.  As a special case,
> ps_max_latency_us=0 will disable APST entirely.  On hardware without
> APST support, ps_max_latency_us will not be exposed in sysfs.
> 
> The ps_max_latency_us parameter for newly-probed devices is set by
> the module parameter nvme_core.default_ps_max_latency_us.
> 
> In theory, the device can expose "default" APST table, but this
> doesn't seem to function correctly on my device (Samsung 950), nor
> does it seem particularly useful.  There is also an optional
> mechanism by which a configuration can be "saved" so it will be
> automatically loaded on reset.  This can be configured from
> userspace, but it doesn't seem useful to support in the driver.
> 
> On my laptop, enabling APST seems to save nearly 1W.
> 
> The hardware tables can be decoded in userspace with nvme-cli.
> 'nvme id-ctrl /dev/nvmeN' will show the power state table and
> 'nvme get-feature -f 0x0c -H /dev/nvme0' will show the current APST
> configuration.
> 
> I called the parameters ps_max_latency_us instead of
> apst_max_latency_us because we might support other power saving
> modes (e.g. non-automonous power state transitions or even runtime
> D3) and the same parameter could control the maximum allowable
> latency for these states as well.
> 
> Signed-off-by: Andy Lutomirski <luto at kernel.org>

Thanks, looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
