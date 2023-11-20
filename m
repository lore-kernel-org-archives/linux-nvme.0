Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF07C54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gr+I5xIuyjbJgIR3B5g4iiXiCk1rHQ+sXfsA4i00pXc=; b=hCq46Q/8VClvwOXjPAlChTxjw4
	YXEkDF/myaXk7413jJAOA2Iaqq9kDqHHjQfHFHsCOVRfJJkBbnh0mcxAvQwsAEUr6G1/QR6C9ryXU
	dAQ2UKPY6dlB3UH6gTCSM4T33kj7EMILwV5CKEDVjde1NdXjo2UCcXRWENZMoolUBTz3JrfSg4Bgp
	00O1ND6ku28AVmsFTGisCMyckPAlD5mF0lokSjSokOzqPa+lpIcmBjmOgy/DSGZJszLOpKDDBfwW3
	C8+PZVK8EKbC44aAeNli24oOlQBckdhqwHuXVb8H5WNawS3re+MOxoOUKIKQQ13qoZwgZ1zCqb0Xi
	XMzZhf0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54Gb-00C96d-1R;
	Mon, 20 Nov 2023 13:24:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54GL-00C8yF-0y
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:24:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2ECF21F895;
	Mon, 20 Nov 2023 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700486663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gr+I5xIuyjbJgIR3B5g4iiXiCk1rHQ+sXfsA4i00pXc=;
	b=FcPeN0sR6c/XXwhj3LLgc/R4JQUxqKD8JMYyMWqTpIiIk8D32ZrMKml/+B0E2Cms/Kz8UR
	2zdWPlfZ4soO332PUhCZRcRHiC3ePPSrQ9kQoHai90JMCnyY8SUFIQNz6ZCNAJw0LvM3BC
	jh/O+1DAK+acMRvXkTBXx4LjS1Lw9aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700486663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gr+I5xIuyjbJgIR3B5g4iiXiCk1rHQ+sXfsA4i00pXc=;
	b=S1TzXYsPAnfG296/HFNBympqdV1xm+AcP+OsUQdZiLgKSnyP39amJTjtQZHBj5Gkd7JF6k
	SgTIeEv1yii7q6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 147E2134AD;
	Mon, 20 Nov 2023 13:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LxsjBAdeW2VdegAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Nov 2023 13:24:23 +0000
Message-ID: <c67482bd-d04e-45b5-8642-bbc3af2ed3c5@suse.de>
Date: Mon, 20 Nov 2023 14:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme/host: Rescan namespace if ns_id is changed
Content-Language: en-US
To: wenxiong@linux.ibm.com, kbusch@kernel.org
Cc: hch@infradead.org, chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
 wenxiong@us.ibm.com
References: <1699999066-5142-1-git-send-email-wenxiong@linux.ibm.com>
From: Hannes Reinecke <hare@suse.de>
Autocrypt: addr=hare@suse.de; keydata=
 xsFNBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABzSpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT7CwZgEEwECAEICGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAhkBFiEEmusOw9rHmm3C+nirbPjKL07IqM8FAmGvIo0FCRyKWvwA
 CgkQbPjKL07IqM8Ocg/8Dt2h8G8prHk6lONEKoUekljoiOTcpdrZZ6oJpykUQ2UewDBt2MtT
 fgfKgz741lC0q5j1+XCIZsGd3xhpFNt+20F94TNMi8pwg06GS/nkWsefmvG4VnIchqA4rD/A
 obfJpkAHQwfQgDbYL44oSLIyPXAprlEKhEImyLBBx5mnJhpR8TCiBipcSuLwWtrAM+q4RpF3
 mhlXhuATwhENs+yiHPhuu4sbDNbJ6juah3Y0YC30DW4S1oUm97zgzvDIcaPnSCe/F11UD770
 G+lgZU/8XaAgGYstvrV6fASCom42GVuhXgJYOqdnXTgogLudQhTvbdpyq5wiVJWA8zhTuZXF
 7Yz5tHRJutDTSEaibWnLVFR/KsjB2xmtTV8Ztb/xsZklHiq3cSco8GS21fOtte1KMJlSiEIg
 8kATAosigjHlmMF8j+w8bUxSvJ9ljpjS4sK8J77YeEdi/kTDUg7TxaruqgSwQYLEgxYrUtga
 DeP3bGzvAwavHz0DFRatSQ0UwBaqugLBLt0VsKjpXO8g61mdZTEG3huvOg2Ko7yY6RFC0rcI
 nxsi9nzkuWOxVt/IzZIdctge01jGPHOuH9qc5m/gVEq5lz6vCc5h4FT30xNxH2j/vneSgbsm
 SXIQXnOsRCb1U3zlrSSP+oYwHsqjsPywu4WYSp0VWwImcP3VInbFrgTOwU0ETorJEQEQAK8Q
 mCCQYLjaG4UColw5wuqeMrze3hNXASclGKxtj9V15kgdMa1wYuqwAsPOT5sQBxlqmC7N+ntz
 JLO+5HofKruEoSMQcBmYj/cgNz2dt2ESB0KIVq1qHRdn+ni+nsoB6Vipu/xgX85EvKUB0uH2
 vMtHrIcWpVpHhYvimXiQRbAWE1IcvF7nkbnr93EG6iPhGsWhffKd6td9unh0fYoCs9zQ1+hq
 ap5u4Y18RCYNu2cIYTnMpxHTO+ZexGmpTv5xq5+55nIvCNNT7LmnfhTg+U47ZDv9t1o8R1d+
 mC9KlaTWjcffou+Q9X88YYMIvNo2fTgF2KKI8QfCgiMJc4BxH7j56ozhNLBWlOfpI2BscuMC
 ELAIPKCAr7eoQYmmH5Y201Tu4V+xxI+TiOqXFzw/6Gf0ipoxZp5f2cERqIp99Hs4qMx20UWc
 FFJeJb+Q4q65F14OMvmBYmNj4il1p88qGO9QW19LAZ2sNSHdK8HmSdKLETepvFuFs3GaoNXP
 LMzC6cUA26PLJWLNLfUOdYLq0rMA2QKTXkLJ4ULqwUW75alHG8Lp/NBMsjkJEYAHoUDHPwe7
 muk01kextiz1V+v8Em5JR9Ej/XZ44Isi/FE+mYw6VwjhYNbcQOTOo0Befk6fH9vSsUYWkzga
 ZI+uIQl0FvgzilIPp83pj8mueD8F3CRJABEBAAHCwXwEGAECACYCGwwWIQSa6w7D2seabcL6
 eKts+MovTsiozwUCYa8jtQUJHIpcJAAKCRBs+MovTsiozxFbEACGvsjoL9Tmi1Kk4BQcyTY9
 A3WuFr27fTFVc/RTKAblIH9CYWcGvzJ5HBQMrD9uKwKkXxhmsSmYO0QCMvh0kEysOASNGVPv
 WciYZXU7apv5715KNJ+KzZpruSohqG2tmDPjfCTQ7kj2BC9HOMo0BcdpXB0r8KfKKUvfIbSW
 4JsJubJrL+FDY4xxYko4t3gfTiFqUEf8hvtX9QbC5m1S58N9KXwOFR7333jsA+sqa6L2hEth
 i/7hcTuKi0U1MDC5WsASFbhbe+yOjPvquHYCcQrFOO+tLvuXSCNCumFcpvDiteNSZUUTD/QB
 0Y/U167yjgktS/hZuuCbrUb+E4TG7EL5+IQGRcAJtQduE2jrCSlN547einmB4vQi4G3ToEk/
 wr5DwYiNEZyO0pJsh85VNLlgnYpzDi3WC5cqePMueogFZDEjMvUeTzwSTM8+scTw6YAcwoHw
 h/Zc/Zqi7mdqcWnNg8WfMcKutB6CaFtJhzShfib+D90F/+r3KGzZdLp1QqLYkfXD3to7XCnR
 QuSHPtufr0nWz7vC3IackvoFHNjQ92ZbHhFbOqLYFHvqaBu8N2PE0YhPh0y0/sjmHM9DHUQh
 jbCcdMlwO54T4hHLBbuR/lU6locuDn9SsF5lFeoPtfnztU0+GtqTw+cRSo0g2ARonLsydcQ0
 YwtooKEemPj2lg==
In-Reply-To: <1699999066-5142-1-git-send-email-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-0.99)[-0.987];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_SHORT(2.98)[0.993];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_052429_670705_3230369A 
X-CRM114-Status: GOOD (  27.79  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/14/23 22:57, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Hi all,
> 
> Namespace is not visible if we detach/delete/create/attach a namespace
> on a new nvme device because of nguid is changed.
> 
> Like Keith's suggestion, we can do the 2nd ns-attach to get new
> namespace available. Test team likes to fix it in the driver.
> 
> The following patch has been tested by test team and works fine.
> 
> Appreciate your suggestion for difference approach!
> 
> Thanks,
> Wendy
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> Tested-by: tjo@us.ibm.com
> 
> ---
>   drivers/nvme/host/core.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88b54cdcbd68..a608a63d3108 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3721,13 +3721,15 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>   	}
>   }
>   
> -static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
> +static bool nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +	bool ns_id_changed = false;
>   
>   	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
>   		dev_err(ns->ctrl->device,
>   			"identifiers changed for nsid %d\n", ns->head->ns_id);
> +		ns_id_changed = true;
>   		goto out;
>   	}
>   
> @@ -3741,21 +3743,24 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	 */
>   	if (ret > 0 && (ret & NVME_SC_DNR))
>   		nvme_ns_remove(ns);
> +
> +	return ns_id_changed;
>   }
>   
> -static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> +static bool nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   {
>   	struct nvme_ns_info info = { .nsid = nsid };
>   	struct nvme_ns *ns;
>   	int ret;
> +	bool ns_rescan = false;
>   
>   	if (nvme_identify_ns_descs(ctrl, &info))
> -		return;
> +		return false;
>   
>   	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
>   		dev_warn(ctrl->device,
>   			"command set not reported for nsid: %d\n", nsid);
> -		return;
> +		return false;
>   	}
>   
>   	/*
> @@ -3777,15 +3782,17 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	 * becomes ready and restart the scan.
>   	 */
>   	if (ret || !info.is_ready)
> -		return;
> +		return false;
>   
>   	ns = nvme_find_get_ns(ctrl, nsid);
>   	if (ns) {
> -		nvme_validate_ns(ns, &info);
> +		ns_rescan = nvme_validate_ns(ns, &info);
>   		nvme_put_ns(ns);
>   	} else {
>   		nvme_alloc_ns(ctrl, &info);
>   	}
> +
> +	return ns_rescan;
>   }
>   
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> @@ -3837,7 +3844,9 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   
>   			if (!nsid)	/* end of the list? */
>   				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			if (nvme_scan_ns(ctrl, nsid))
> +				nvme_scan_ns(ctrl, nsid);
> +
>   			while (++prev < nsid)
>   				nvme_ns_remove_by_nsid(ctrl, prev);
>   		}
No. If the namespace has changed we should abort scanning altogether, as 
there is no guarantee that the _previous_ namespaces in the list have 
not changed.
We should rather abort and wait for the NS changed AEN to be signalled, 
which will trigger a rescan anyway.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


