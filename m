From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 16 Sep 2016 17:49:55 -0700
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <cover.1474049701.git.luto@kernel.org>
References: <cover.1474049701.git.luto@kernel.org>
Message-ID: <1474073395.10494.13.camel@linux.intel.com>

On Fri, 2016-09-16@11:16 -0700, Andy Lutomirski wrote:
> Hi all-
> 
> Here's v4 of the APST patch set.??The biggest bikesheddable thing (I
> think) is the scaling factor.??I currently have it hardcoded so that
> we wait 50x the total latency before entering a power saving state.
> On my Samsung 950, this means we enter state 3 (70mW, 0.5ms entry
> latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms entry
> latency, 22ms exit latency) after 1200ms.??I have the default max
> latency set to 25ms.
> 
> FWIW, in practice, the latency this introduces seems to be well
> under 22ms, but my benchmark is a bit silly and I might have
> measured it wrong.??I certainly haven't observed a slowdown just
> using my laptop.
> 
> This time around, I changed the names of parameters after Jay
> Frayensee got confused by the first try.??Now they are:
> 
> ?- ps_max_latency_us in sysfs: actually controls it.
> ?- nvme_core.default_ps_max_latency_us: sets the default.
> 
> Yeah, they're mouthfuls, but they should be clearer now.
>?

I took the patches and applied them to one of my NVMe fabric hosts on
my NVMe-over-Fabrics setup. ?Basically, it doesn't test much other than
Andy's explanation that?"ps_max_latency_us" does not appear in any of
/sys/block/nvmeXnY sysfs nodes (I have 7) so seems good to me on this
front.

Tested-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
[jpf: defaults benign to NVMe-over-Fabrics]
