Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46113CD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGggALgHzCoPtLdgY/KCVV2cuvNqQvvmKNTA2nt3QnI=; b=fQOKXkzCSjswzLRtMiKqoHf6Wl
	Nk9njKolxc6W0UqpvghcP20F547u/ZwUOxo605Eluf3Xf0sK8KqOYulzhF9s8Qb2Pb3GIgQwO9S3i
	fXudFO5RtK7qSpQwyEIrxOs6+HuPv2pzeh3DABJHmgCHvT5dLdbhHfno95y6b2bEj3efoQ+atz0oh
	BfpTHKSNDWZuEW2A3+ofvYvDj6kbJPark5Q7NTBWIcTfury3XDs3Wo00fxzpQ0wJyhlQkqyVR6J1E
	y8Gb3J42NZOiNudEzR9VRTMdoc3nEBIrR9xBL2FjFNpbZUuN2RmqqcRBmK+NNyj4zuVlt/4z5DPdh
	QG4g4Bcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPgVj-00000004crT-2QPh;
	Wed, 20 May 2026 12:58:55 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPgVg-00000004cqm-3AvP
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 12:58:53 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-4585a116a4aso4012596f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281931; x=1779886731; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGggALgHzCoPtLdgY/KCVV2cuvNqQvvmKNTA2nt3QnI=;
        b=FFUuYuDbrGOwCTs43TnMswbdRxJAhDzhGBcL79qYBPir30dSLsurnkVCXI9iQLlcDx
         VjIM5LumgdpWFjNYgllumeNtTDHMaKu1Mo4EgBPIsZoHaeKyIkDBDeJt4sf+T7epyUT4
         W8LKQHC6kLIXPmMZbrWzvFhZMQf16swkB9RMbhmuzmC0cbmPGthfrRH/e6JLGiF08g/K
         ZyJaxysTLsNxnSNNW2zyKzE3Krl/gazciDD+1wTgGBDiMNfmLsOMCQrzm6Ihue5IPoHe
         /9GDdq+whW1RyqpYO9m8ExG1V2tLPNGlis0tXdS4oOj8hMxP/kGfdlOjH1duUP6ylutt
         HDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281931; x=1779886731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGggALgHzCoPtLdgY/KCVV2cuvNqQvvmKNTA2nt3QnI=;
        b=Qfw0p84AEe+wsx1tRzkRiQrCqL5C1+NfaOfBPOPMKgcw2YmKzzkFq8fJranBcG5C3Q
         QSxAFQ6D/7r37U5qq2MRffPIVEiz6kfyHPbMKfCQzzLiCAicoQIwUaZTK0sEN00Fi4ZZ
         nfFIZIzkjZQlt8U8tJKJaerloHZxyGN6DGlW3EkSTFKU2fu04ma5M6foCclzeXR0ecta
         7v2ZDgSkUO8uvJ93vsoKx2Zxmn/7UdlUBEhRWTklRMx9IMFpeDwJafSG2DFPNprLtQoV
         WGIPA/sIGAEiVlKfycLklcyCn6RRt+B07gxtsXG0avLQOhO+rj9VYxaym6AlTCTt1Hr8
         DATg==
X-Forwarded-Encrypted: i=1; AFNElJ9a3jmXDUkNIFbeSoi3i66c2iHHCgY1eGWHwK+VjVCgVDmKYkFZZO/1nOfyAuQOaSzJAtXK7d4qB5Hf@lists.infradead.org
X-Gm-Message-State: AOJu0YwuOuv9H0tb2V/D48IH8sDcaC63DrWK8WsIuHBe9sYoXxPojm9L
	65iXXuJzD7vRy/Kg0/GFzA4QAX/pM+a4DmZHGnzr+o2a7k2TAZeqv3Gs
X-Gm-Gg: Acq92OFjPC51c1P9ygWg0/TtOBacRs5LoRC6ggaQEK/jeflHhLzTCcXV59xVkhlu4+j
	GJsQiQWV7Ev/KW9+1Ftgh3oQkLAVmsjzuBcqb2exrqXPT1HDOuZhQsgLIRMiHsjzB9eBrMKBgO7
	yYfbrpkDvZFL2cQeqXAN2rcfkP4NBfoXhdSlVAOzySTIHgHfAnkJ2i90q2H/ksaiQGFDRJJ/Lpf
	gko8oGcmyfQA7ZhsR15rSAzagaXN7gUcV7cI0D5MLXTfCj+pzd/Md/KEqVA3NMQhCetfG7Dw9aM
	fOtDIZ57mNPzTAmezjXkZgyxO8G2TFwYWHZxdL4FxCgGf35whJHgcbGTC8AZgNBv+wS6L3B8bFp
	QQPL0ZyzH+TlHyG+qbTy/wL0U+lIvkOpjovAF4zBjeJX5N4IOYHABrJUOWYiNtimrFAr+YDu5HO
	jLikhad6pv3hLrE7x+v2X4nDX66O+25SClY7W7vTKARJ2EPMoqwwRtV875Ussd+QAK
X-Received: by 2002:a05:6000:4011:b0:45d:41e0:467b with SMTP id ffacd0b85a97d-45e5c57d3b5mr38701966f8f.3.1779281930642;
        Wed, 20 May 2026 05:58:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm58513115f8f.10.2026.05.20.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:58:50 -0700 (PDT)
Date: Wed, 20 May 2026 13:58:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Nilesh Javali
 <njavali@marvell.com>, Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shyam Sundar <ssundar@marvell.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
 Bryan Gurney <bgurney@redhat.com>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260520135848.6df9f7d2@pumpkin>
In-Reply-To: <20260519190615.2761667-1-michael.bommarito@gmail.com>
References: <20260518143706.2808177-1-michael.bommarito@gmail.com>
	<20260519190615.2761667-1-michael.bommarito@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_055852_843875_C76A095A 
X-CRM114-Status: GOOD (  31.71  )
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

On Tue, 19 May 2026 15:06:15 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

> An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
> frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
> in the generic FC transport. This is not a local userspace or IP
> network path; the attacker must be able to inject fabric traffic, for
> example as a compromised switch or fabric controller, or as a same-zone
> N_Port on a fabric that permits source spoofing.
> 
> The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
> counter against the 32-bit on-wire pname_count field, and did not bound
> pname_count by the descriptor body already validated by the TLV walker.
> A pname_count of 256 therefore wraps the counter and keeps the loop
> condition true indefinitely.
> 
> Factor the shared pname_list[] walk into one helper, widen the counter
> to u32, and clamp pname_count against the entries that fit in the
> descriptor body before iterating.
> 
> Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Changes in v3:
> - State the fabric-adjacent threat model explicitly in the commit
>   message and clarify that this is not local userspace or IP-network
>   reachable.
> - Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
> - Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
>   body length calculation.
> - Factor the duplicate LI and peer-congestion pname walker into a common
>   helper while preserving the LI-only host-stat update.
> 
> Changes in v2:
> - Drop the redundant cover letter shipped with v1.  A single-patch send
>   does not need one, and the v1 cover carried stale draft markers.
> 
>  drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index dce95e361daf0..0684d8c69c3c6 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
>  	}
>  }
>  
> +static void
> +fc_fpin_pname_stats_update(struct Scsi_Host *shost,
> +			   struct fc_rport *attach_rport, u16 event_type,
> +			   u32 desc_len, u32 fixed_len, u32 pname_count,
> +			   __be64 *pname_list,
> +			   void (*stats_update)(u16 event_type,
> +						struct fc_fpin_stats *stats))
> +{
> +	u32 i, max_count;
> +	struct fc_rport *rport;
> +	u64 wwpn;
> +
> +	if (desc_len < fixed_len)
> +		max_count = 0;
> +	else
> +		max_count = (desc_len - fixed_len) / sizeof(pname_list[0]);
> +	pname_count = min_t(u32, pname_count, max_count);

No min_t() please, everything is unsigned so min() in fine.
The above might even more readable without the extra variable:
	if (desc_len < fixed_len)
		pname_count = min(pname_count, (desc_len - fixed_len) / sizeof(pname_list[0]));

If you think the line is too long s/pname_count/count/g

-- David

> +
> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			stats_update(event_type, &rport->fpin_stats);
> +		}
> +	}
> +}
> +
>  /*
>   * fc_fpin_li_stats_update - routine to update Link Integrity
>   * event statistics.
> @@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
>  static void
>  fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
>  {
> -	u8 i;
>  	struct fc_rport *rport = NULL;
>  	struct fc_rport *attach_rport = NULL;
>  	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
>  	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
>  	u16 event_type = be16_to_cpu(li_desc->event_type);
> -	u64 wwpn;
>  
>  	rport = fc_find_rport_by_wwpn(shost,
>  				      be64_to_cpu(li_desc->attached_wwpn));
> @@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
>  		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
>  	}
>  
> -	if (be32_to_cpu(li_desc->pname_count) > 0) {
> -		for (i = 0;
> -		    i < be32_to_cpu(li_desc->pname_count);
> -		    i++) {
> -			wwpn = be64_to_cpu(li_desc->pname_list[i]);
> -			rport = fc_find_rport_by_wwpn(shost, wwpn);
> -			if (rport &&
> -			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> -			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> -				if (rport == attach_rport)
> -					continue;
> -				fc_li_stats_update(event_type,
> -						   &rport->fpin_stats);
> -			}
> -		}
> -	}
> +	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
> +				   be32_to_cpu(li_desc->desc_len),
> +				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
> +				   be32_to_cpu(li_desc->pname_count),
> +				   li_desc->pname_list, fc_li_stats_update);
>  
>  	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
>  		fc_li_stats_update(event_type, &fc_host->fpin_stats);
> @@ -827,13 +845,11 @@ static void
>  fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
>  				struct fc_tlv_desc *tlv)
>  {
> -	u8 i;
>  	struct fc_rport *rport = NULL;
>  	struct fc_rport *attach_rport = NULL;
>  	struct fc_fn_peer_congn_desc *pc_desc =
>  	    (struct fc_fn_peer_congn_desc *)tlv;
>  	u16 event_type = be16_to_cpu(pc_desc->event_type);
> -	u64 wwpn;
>  
>  	rport = fc_find_rport_by_wwpn(shost,
>  				      be64_to_cpu(pc_desc->attached_wwpn));
> @@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
>  		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
>  	}
>  
> -	if (be32_to_cpu(pc_desc->pname_count) > 0) {
> -		for (i = 0;
> -		    i < be32_to_cpu(pc_desc->pname_count);
> -		    i++) {
> -			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
> -			rport = fc_find_rport_by_wwpn(shost, wwpn);
> -			if (rport &&
> -			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> -			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> -				if (rport == attach_rport)
> -					continue;
> -				fc_cn_stats_update(event_type,
> -						   &rport->fpin_stats);
> -			}
> -		}
> -	}
> +	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
> +				   be32_to_cpu(pc_desc->desc_len),
> +				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
> +				   be32_to_cpu(pc_desc->pname_count),
> +				   pc_desc->pname_list, fc_cn_stats_update);
>  }
>  
>  /*


