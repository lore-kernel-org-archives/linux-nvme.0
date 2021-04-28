Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 12:43:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73135613EF
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 12:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73135613EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BLbrOFUY8fzMxY7NB2WZv0x98BeRAhxkCyL31qFRDMM=; b=n/i/xEuPIrG5IvifpW+efaQGG
	dkSX0TWNNXFgAd0r9M+CUqIb873NWNA8D+9E/jskvCnTM8cz/VWiyzHcgtAW01OzEz4hTuVha+ECJ
	CRaTuX4fDizI1zr+bdjjwoKFRRYKpjoIzOT+4kiG8t7AsbrwKHN6RvkjMLhlmPVS/6JbX55cQVcZ8
	MFNnD/rvGuWpXwNmL7/PudJ5OJdAIBsSCwHMCW7M2PU7NYh62XeBeR6MhE1dUx9RKcgge8gQxGrE6
	tOlOfiOVruSfNctd9BnUfd2bGNtItwmp+54bUcDeOu1Lg+kCJ4LJ2ZHtBVaNK7nx1+W/DRq+rAiiS
	19ZiTVwlw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbjX0-003Ta1-JK; Wed, 28 Apr 2021 12:43:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbjWx-003TYx-8Q
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 12:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YbxFFw+jKp9Wnpzy4smuMM1Sfjoz0xD9MMmw6qVlgws=; b=a52ggsWRSjQkehMnIJh/aji6fA
 QSAo6N4eIlVjsh8z7YZReVzEIiRfF+w7UlxRsc92g/PtFgKZ65s3r4Umal13JjNi4LCN+ECHR5i1L
 wf3abZ6e7/oMgUXkEqnAcu+J/uR9g6ZJKcgwVG3C7AmDpvamhEx+AQ/L1ucVQRd//34qjXC0ZqSmd
 AmrJ6u/8eXoHHc6nbYU0RKhNv0qwmYpVzf30FIEb45WfVDOGzNrlk2Gt59v8fQKyTvq3jvdvGC4/3
 7t4G/WNx2HWh9m7EcNb9jjeMESIMHpQdoxlFnHK3+uo7EgqoMfBdTFeGRpcZRoSlME0wtxgq/YHO7
 b/p2w7Nw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbjWt-00HQpo-85
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 12:43:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4450568BEB; Wed, 28 Apr 2021 14:42:56 +0200 (CEST)
Date: Wed, 28 Apr 2021 14:42:56 +0200
From: "hch@lst.de" <hch@lst.de>
To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
Message-ID: <20210428124256.GB28566@lst.de>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_054259_626306_A0A9F7CF 
X-CRM114-Status: GOOD (  62.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Adding Andy who wrote the original APST code.

On Wed, Apr 28, 2021 at 09:27:36AM +0000, Alexey Bogoslavsky wrote:
> From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
> 
> The algorithm that was used until now for building the APST configuration
> table has been found to produce entries with excessively long ITPT
> (idle time prior to transition) for devices declaring relatively long
> entry and exit latencies for non-operational power states. This leads
> to unnecessary waste of power and, as a result, failure to pass
> mandatory power consumption tests on Chromebook platforms.
> 
> The new algorithm is based on two predefined ITPT values and two
> predefined latency tolerances. Based on these values, as well as on
> exit and entry latencies reported by the device, the algorithm looks
> for up to 2 suitable non-operational power states to use as primary
> and secondary APST transition targets. The predefined values are
> supplied to the nvme driver as module parameters:
> 
>  - apst_primary_timeout_ms (default: 100)
>  - apst_secondary_timeout_ms (default: 2000)
>  - apst_primary_latency_tol_us (default: 15000)
>  - apst_secondary_latency_tol_us (default: 100000)
> 
> The algorithm echoes the approach used by Intel's and Microsoft's drivers
> on Windows. The specific default parameter values are also based on those
> drivers. Yet, this patch doesn't introduce the ability to dynamically
> regenerate the APST table in the event of switching the power source from
> AC to battery and back. Adding this functionality may be considered in the
> future. In the meantime, the timeouts and tolerances reflect a compromise
> between values used by Microsoft for AC and battery scenarios.
> 
> In most NVMe devices the new algorithm causes them to implement a more
> aggressive power saving policy. While beneficial in most cases, this
> sometimes comes at the price of a higher IO processing latency in certain
> scenarios as well as at the price of a potential impact on the drive's
> endurance (due to more frequent context saving when entering deep non-
> operational states). So in order to provide a fallback for systems where
> these regressions cannot be tolerated, the patch allows to revert to
> the legacy behavior by setting either apst_primary_timeout_ms or
> apst_primary_latency_tol_us parameter to 0. Eventually (and possibly after
> fine tuning the default values of the module parameters) the legacy behavior
> can be removed.
> 
> TESTING.
> 
> The new algorithm has been extensively tested. Initially, simulations were
> used to compare APST tables generated by old and new algorithms for a wide
> range of devices. After that, power consumption, performance and latencies
> were measured under different workloads on devices from multiple vendors
> (WD, Intel, Samsung, Hynix, Kioxia). Below is the description of the tests
> and the findings.
> 
> General observations.
> The effect the patch has on the APST table varies depending on the entry and
> exit latencies advertised by the devices. For some devices, the effect is
> negligible (e.g. Kioxia KBG40ZNS), for some significant, making the
> transitions to PS3 and PS4 much quicker (e.g. WD SN530, Intel 760P), or making
> the sleep deeper, PS4 rather than PS3 after a similar amount of time (e.g.
> SK Hynix BC511). For some devices (e.g. Samsung PM991) the effect is mixed:
> the initial transition happens after a longer idle time, but takes the device
> to a lower power state.
> 
> Workflows.
> In order to evaluate the patch's effect on the power consumption and latency,
> 7 workflows were used for each device. The workflows were designed to test
> the scenarios where significant differences between the old and new behaviors
> are most likely. Each workflow was tested twice: with the new and with the
> old APST table generation implementation. Power consumption, performance and
> latency were measured in the process. The following workflows were used:
> 1) Consecutive write at the maximum rate with IO depth of 2, with no pauses
> 2) Repeated pattern of 1000 consecutive writes of 4K packets followed by 50ms
>    idle time
> 3) Repeated pattern of 1000 consecutive writes of 4K packets followed by 150ms
>    idle time
> 4) Repeated pattern of 1000 consecutive writes of 4K packets followed by 500ms
>    idle time
> 5) Repeated pattern of 1000 consecutive writes of 4K packets followed by 1.5s
>    idle time
> 6) Repeated pattern of 1000 consecutive writes of 4K packets followed by 5s
>    idle time
> 7) Repeated pattern of a single random read of a 4K packet followed by 150ms
>    idle time
> 
> Power consumption
> Actual power consumption measurements produced predictable results in
> accordance with the APST mechanism's theory of operation.
> Devices with long entry and exit latencies such as WD SN530 showed huge
> improvement on scenarios 4,5 and 6 of up to 62%. Devices such as Kioxia
> KBG40ZNS where the resulting APST table looks virtually identical with
> both legacy and new algorithms, showed little or no change in the average power
> consumption on all workflows. Devices with extra short latencies such as
> Samsung PM991 showed moderate increase in power consumption of up to 18% in
> worst case scenarios.
> In addition, on Intel and Samsung devices a more complex impact was observed
> on scenarios 3, 4 and 7. Our understanding is that due to longer stay in deep
> non-operational states between the writes the devices start performing background
> operations leading to an increase of power consumption. With the old APST tables
> part of these operations are delayed until the scenario is over and a longer idle
> period begins, but eventually this extra power is consumed anyway.
> 
> Performance.
> In terms of performance measured on sustained write or read scenarios, the
> effect of the patch is minimal as in this case the device doesn't enter low power
> states.
> 
> Latency
> As expected, in devices where the patch causes a more aggressive power saving
> policy (e.g. WD SN530, Intel 760P), an increase in latency was observed in
> certain scenarios. Workflow number 7, specifically designed to simulate the
> worst case scenario as far as latency is concerned, indeed shows a sharp
> increase in average latency (~2ms -> ~53ms on Intel 760P and 0.6 -> 10ms on
> WD SN530). The latency increase on other workloads and other devices is much
> milder or non-existent.
> 
> Signed-off-by: Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>
> ---
>  drivers/nvme/host/core.c | 89 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 78 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2f45e8fcdd7c..9768d2e84562 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -57,6 +57,26 @@ static bool force_apst;
>  module_param(force_apst, bool, 0644);
>  MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
>  
> +static unsigned long apst_primary_timeout_ms = 100;
> +module_param(apst_primary_timeout_ms, ulong, 0644);
> +MODULE_PARM_DESC(apst_primary_timeout_ms,
> +	"primary APST timeout in ms");
> +
> +static unsigned long apst_secondary_timeout_ms = 2000;
> +module_param(apst_secondary_timeout_ms, ulong, 0644);
> +MODULE_PARM_DESC(apst_secondary_timeout_ms,
> +	"secondary APST timeout in ms");
> +
> +static unsigned long apst_primary_latency_tol_us = 15000;
> +module_param(apst_primary_latency_tol_us, ulong, 0644);
> +MODULE_PARM_DESC(apst_primary_latency_tol_us,
> +	"primary APST latency tolerance in us");
> +
> +static unsigned long apst_secondary_latency_tol_us = 100000;
> +module_param(apst_secondary_latency_tol_us, ulong, 0644);
> +MODULE_PARM_DESC(apst_secondary_latency_tol_us,
> +	"secondary APST latency tolerance in us");
> +
>  static bool streams;
>  module_param(streams, bool, 0644);
>  MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
> @@ -2185,14 +2205,54 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>  	return ret;
>  }
>  
> +/*
> + * The function checks whether the given total (exlat + enlat) latency of
> + * a power state allows the latter to be used as an APST transition target.
> + * It does so by comparing the latency to the primary and secondary latency
> + * tolerances defined by module params. If there's a match, the corresponding
> + * timeout value is returned and the matching tolerance index (1 or 2) is
> + * reported.
> + */
> +static bool nvme_apst_get_transition_time(u64 total_latency,
> +		u64 *transition_time, unsigned *last_index)
> +{
> +	if (total_latency <= apst_primary_latency_tol_us) {
> +		if (*last_index == 1)
> +			return false;
> +		*last_index = 1;
> +		*transition_time = apst_primary_timeout_ms;
> +		return true;
> +	}
> +	if (apst_secondary_timeout_ms &&
> +		total_latency <= apst_secondary_latency_tol_us) {
> +		if (*last_index <= 2)
> +			return false;
> +		*last_index = 2;
> +		*transition_time = apst_secondary_timeout_ms;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  /*
>   * APST (Autonomous Power State Transition) lets us program a table of power
>   * state transitions that the controller will perform automatically.
> - * We configure it with a simple heuristic: we are willing to spend at most 2%
> - * of the time transitioning between power states.  Therefore, when running in
> - * any given state, we will enter the next lower-power non-operational state
> - * after waiting 50 * (enlat + exlat) microseconds, as long as that state's exit
> - * latency is under the requested maximum latency.
> + *
> + * Depending on module params, one of the two supported techniques will be used:
> + *
> + * - If the parameters provide explicit timeouts and tolerances, they will be
> + *   used to build a table with up to 2 non-operational states to transition to.
> + *   The default parameter values were selected based on the values used by
> + *   Microsoft's and Intel's NVMe drivers. Yet, since we don't implement dynamic
> + *   regeneration of the APST table in the event of switching between external
> + *   and battery power, the timeouts and tolerances reflect a compromise
> + *   between values used by Microsoft for AC and battery scenarios.
> + * - If not, we'll configure the table with a simple heuristic: we are willing
> + *   to spend at most 2% of the time transitioning between power states.
> + *   Therefore, when running in any given state, we will enter the next
> + *   lower-power non-operational state after waiting 50 * (enlat + exlat)
> + *   microseconds, as long as that state's exit latency is under the requested
> + *   maximum latency.
>   *
>   * We will not autonomously enter any non-operational state for which the total
>   * latency exceeds ps_max_latency_us.
> @@ -2208,6 +2268,7 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
>  	int max_ps = -1;
>  	int state;
>  	int ret;
> +	unsigned last_lt_index = UINT_MAX;
>  
>  	/*
>  	 * If APST isn't supported or if we haven't been initialized yet,
> @@ -2266,13 +2327,19 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
>  			le32_to_cpu(ctrl->psd[state].entry_lat);
>  
>  		/*
> -		 * This state is good.  Use it as the APST idle target for
> -		 * higher power states.
> +		 * This state is good. It can be used as the APST idle target
> +		 * for higher power states.
>  		 */
> -		transition_ms = total_latency_us + 19;
> -		do_div(transition_ms, 20);
> -		if (transition_ms > (1 << 24) - 1)
> -			transition_ms = (1 << 24) - 1;
> +		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
> +			if (!nvme_apst_get_transition_time(total_latency_us,
> +					&transition_ms, &last_lt_index))
> +				continue;
> +		} else {
> +			transition_ms = total_latency_us + 19;
> +			do_div(transition_ms, 20);
> +			if (transition_ms > (1 << 24) - 1)
> +				transition_ms = (1 << 24) - 1;
> +		}
>  
>  		target = cpu_to_le64((state << 3) | (transition_ms << 8));
>  		if (max_ps == -1)
> -- 
> 2.17.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
