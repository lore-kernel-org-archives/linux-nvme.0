From: axboe@fb.com (Jens Axboe)
Date: Thu, 22 Sep 2016 08:23:35 -0600
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <cover.1474049701.git.luto@kernel.org>
References: <cover.1474049701.git.luto@kernel.org>
Message-ID: <13b0fe95-01b8-89d7-df76-efc1aa14b27a@fb.com>

On 09/16/2016 12:16 PM, Andy Lutomirski wrote:
> Hi all-
>
> Here's v4 of the APST patch set.  The biggest bikesheddable thing (I
> think) is the scaling factor.  I currently have it hardcoded so that
> we wait 50x the total latency before entering a power saving state.
> On my Samsung 950, this means we enter state 3 (70mW, 0.5ms entry
> latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms entry
> latency, 22ms exit latency) after 1200ms.  I have the default max
> latency set to 25ms.
>
> FWIW, in practice, the latency this introduces seems to be well
> under 22ms, but my benchmark is a bit silly and I might have
> measured it wrong.  I certainly haven't observed a slowdown just
> using my laptop.
>
> This time around, I changed the names of parameters after Jay
> Frayensee got confused by the first try.  Now they are:
>
>  - ps_max_latency_us in sysfs: actually controls it.
>  - nvme_core.default_ps_max_latency_us: sets the default.
>
> Yeah, they're mouthfuls, but they should be clearer now.

The only thing I don't like about this is the fact that's it's a driver 
private thing. Similar to ALPM on SATA, it's yet another knob that needs 
to be set. It we put it somewhere generic, then at least we could 
potentially use it in a generic fashion.

Additionally, it should not be on by default.

-- 
Jens Axboe
