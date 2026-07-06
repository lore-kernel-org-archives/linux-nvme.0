Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ADAC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZ2TXLLWVFlivLuiyWvIvIoOfpPB9RPC9RMVu4sZNwM=; b=qVkVSNNZF7xdl0Sc7PQxYMEDzg
	oTItFtaYW7/pdrK1X18vahsoBNL1Y0FNcOb/ORn6tO5yRf7oweeJkyy/YLX7SSvyWzm1XojGzTtIm
	UV/jglLhTGeqnqqCEne1xN/yPRvs+P0hckknD4lWBU40hUAE+wQ5am5RQPSEEqjKupkoun/6jhK+a
	SWLlHcLx5rjH6SLRs+YWw7lBAeObRRbOUzTs41+x7IJpUTuWrGQ1ZxO+AiLU2UFxhn6Jmp96hf0EQ
	dkDJwjeQHlgOQYr+TKnaGqYgrutXibMpr75xssYG4j9aL3dI5kDJJFINBPO8azvcDtv2UZjjxS8Fs
	VhFmW9kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wggYs-0000000CDCm-0vAP;
	Mon, 06 Jul 2026 10:28:26 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wggYp-0000000CDC2-0og2
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 10:28:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783333701; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XZ2TXLLWVFlivLuiyWvIvIoOfpPB9RPC9RMVu4sZNwM=;
	b=l95+q8NkE7ZHbtT3dOI/Fto/FQir8KYkOBBn6dwnI8Ns4Vt1nn10pdO4Wb0aOBPJbb+gbM5i+vBAVdBgshDCctEC0QxkkEG/2WXwzyB69MDgh0fkfdW3miR2vHutVY37763HpjvnLJPl+Gfj4upc1+/WB1610orRG49tGtunlUI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X6UG4v2_1783333699;
Received: from 30.178.84.17(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6UG4v2_1783333699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 18:28:20 +0800
Message-ID: <551ef1f7-ceec-4e4d-9555-0661ecbcc845@linux.alibaba.com>
Date: Mon, 6 Jul 2026 18:28:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>,
 linux-nvme@lists.infradead.org
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
 <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
 <f0c00d47-0f33-4c9a-84ea-2fb82cd4d102@linux.alibaba.com>
 <1b56186c-9e5b-4e9a-813e-74e4d1511738@linux.alibaba.com>
 <78c97eb1-a69e-4f14-977d-f3950db1a0e2@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <78c97eb1-a69e-4f14-977d-f3950db1a0e2@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_032823_717366_3BE4476C 
X-CRM114-Status: GOOD (  14.91  )
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



在 2026/7/6 15:59, Daniel Wagner 写道:
> On Mon, Jul 06, 2026 at 11:10:41AM +0800, Guixin Liu wrote:
>>>>> Example output with two registered hosts and an active holder:
>>>>>
>>>>>     $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
>>>>>     enable : 1
>>>>>     generation : 2
>>>>>     notify_mask : 0x0
>>>>>     rtype : write_exclusive
>>>>>     holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>>>>     registrants:
>>>>>       hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>>>>>       hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222
>>>> I expect blktests will make use of this interface eventually. The parser
>>>> for this wont be dead simple, sure doable but not simple. If you see a
>>>> way to make a bit simpler I wouldn't mind.
>>> How about this:
>>>
>>> 1. One holer, multi registrants:
>>>    enable=1
>>>    generation=2
>>>    notify_mask=0x0
>>>    rtype=write_exclusive
>>>    holder=11111111-1111-1111-1111-111111111111,0x1111
>>>    reg=11111111-1111-1111-1111-111111111111,0x1111
>>>    reg=22222222-2222-2222-2222-222222222222,0x2222
>>>
>>> 2. No holder, multi registrants:
>>>    enable=1
>>>    generation=1
>>>    notify_mask=0x0
>>>    rtype=none
>>>    holder=none
>>>    reg=11111111-1111-1111-1111-111111111111,0x1111
>>>    reg=22222222-2222-2222-2222-222222222222,0x2222
>>>
>>> 3. No registrant:
>>>    enable=1
>>>    generation=0
>>>    notify_mask=0x0
>>>    rtype=none
>>>    holder=none
>>>
>>> 4. Reservation not enabled:
>>>    enable=0
>>>
>>> Otherwise, the notify_mask can be stringization:
>>>
>>>    notify_mask=reg_preempted,resv_released,resv_preempted
> Sorry, missed your previous post. This looks easier to parser (*), but I
> think it's up to Shiinchiro to make the call.
>
> Thanks,
> Daniel
>
> (*) I asked a LLM to generate one and it looks straight forward.
>
> #!/bin/bash
>
> # Clean plaintext data with email/quote formatting completely removed
> DATA=$(cat << 'EOF'
>    19   enable=1
>    20   generation=2
>    21   notify_mask=0x0
>    22   rtype=write_exclusive
>    23   holder=11111111-1111-1111-1111-111111111111,0x1111
>    24   reg=11111111-1111-1111-1111-111111111111,0x1111
>    25   reg=22222222-2222-2222-2222-222222222222,0x2222
>    26
>    27 2. No holder, multi registrants:
>    28   enable=1
>    29   generation=1
>    30   notify_mask=0x0
>    31   rtype=none
>    32   holder=none
>    33   reg=11111111-1111-1111-1111-111111111111,0x1111
>    34   reg=22222222-2222-2222-2222-222222222222,0x2222
>    35
>    36 3. No registrant:
>    37   enable=1
>    38   generation=0
>    39   notify_mask=0x0
>    40   rtype=none
>    41   holder=none
>    42
>    43 4. Reservation not enabled:
>    44   enable=0
> EOF
> )
>
> # Declare an associative array to store parsed data
> declare -A INI_DATA
>
> # Tracks the active section namespace
> current_section="1. Default"
>
> # Read line-by-line
> while IFS= read -r raw_line; do
>      # Strip leading line numbers (e.g., "  19 ") and trim surrounding spaces
>      line=$(echo "$raw_line" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//; s/^[[:space:]]+//; s/[[:space:]]+$//')
>
>      # Skip empty lines
>      [[ -z "$line" ]] && continue
>
>      # Check if the line is a section header (e.g., "2. No holder, multi registrants:")
>      if [[ "$line" =~ ^[0-9]+\. ]]; then
>          current_section="$line"
>          continue
>      fi
>
>      # Parse Key=Value configurations
>      if [[ "$line" == *"="* ]]; then
>          key="${line%%=*}"
>          val="${line#*=}"
>          
>          # Build a compound key: "SectionName|||KeyName"
>          map_key="${current_section}|||${key}"
>
>          # If key already exists in this section, append value using a pipe '|' delimiter
>          if [[ -n "${INI_DATA[$map_key]}" ]]; then
>              INI_DATA[$map_key]+="|$val"
>          else
>              INI_DATA[$map_key]="$val"
>          fi
>      fi
> done <<< "$DATA"
>
> # --- Demonstrate Accessing the Generated Arrays ---
> echo "=== PARSED DATA STRUCTURE ==="
>
> for compound_key in "${!INI_DATA[@]}"; do
>      section="${compound_key%%|||*}"
>      key="${compound_key##*|||}"
>      raw_value="${INI_DATA[$compound_key]}"
>
>      echo "[$section]"
>      
>      # If the value contains our delimiter '|', turn it into a real Bash array
>      if [[ "$raw_value" == *"|"* ]]; then
>          IFS='|' read -r -a val_array <<< "$raw_value"
>          echo "  Key '$key' is an ARRAY (${#val_array[@]} elements):"
>          for i in "${!val_array[@]}"; do
>              echo "    -> index [$i]: ${val_array[$i]}"
>          done
>      else
>          echo "  Key '$key' is a STRING:"
>          echo "    -> value: $raw_value"
>      fi
>      echo "----------------------------------------"
> done
>
>
> === PARSED DATA STRUCTURE ===
> [3. No registrant:]
>    Key 'rtype' is a STRING:
>      -> value: none
> ----------------------------------------
> [3. No registrant:]
>    Key 'generation' is a STRING:
>      -> value: 0
> ----------------------------------------
> [1. Default]
>    Key 'generation' is a STRING:
>      -> value: 2
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'holder' is a STRING:
>      -> value: none
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'reg' is an ARRAY (2 elements):
>      -> index [0]: 11111111-1111-1111-1111-111111111111,0x1111
>      -> index [1]: 22222222-2222-2222-2222-222222222222,0x2222
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'enable' is a STRING:
>      -> value: 1
> ----------------------------------------
> [1. Default]
>    Key 'enable' is a STRING:
>      -> value: 1
> ----------------------------------------
> [1. Default]
>    Key 'notify_mask' is a STRING:
>      -> value: 0x0
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'generation' is a STRING:
>      -> value: 1
> ----------------------------------------
> [3. No registrant:]
>    Key 'notify_mask' is a STRING:
>      -> value: 0x0
> ----------------------------------------
> [1. Default]
>    Key 'holder' is a STRING:
>      -> value: 11111111-1111-1111-1111-111111111111,0x1111
> ----------------------------------------
> [3. No registrant:]
>    Key 'holder' is a STRING:
>      -> value: none
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'rtype' is a STRING:
>      -> value: none
> ----------------------------------------
> [3. No registrant:]
>    Key 'enable' is a STRING:
>      -> value: 1
> ----------------------------------------
> [4. Reservation not enabled:]
>    Key 'enable' is a STRING:
>      -> value: 0
> ----------------------------------------
> [1. Default]
>    Key 'rtype' is a STRING:
>      -> value: write_exclusive
> ----------------------------------------
> [2. No holder, multi registrants:]
>    Key 'notify_mask' is a STRING:
>      -> value: 0x0
> ----------------------------------------
> [1. Default]
>    Key 'reg' is an ARRAY (2 elements):
>      -> index [0]: 11111111-1111-1111-1111-111111111111,0x1111
>      -> index [1]: 22222222-2222-2222-2222-222222222222,0x2222
> ----------------------------------------
OK, this seems feasible.

Hi Shin'ichiro:
     Does this work for you?

Best Regards,
Guixin Liu


