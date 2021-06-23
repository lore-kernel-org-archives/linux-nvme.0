Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10985C48BC2
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:33:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB4E61220
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4E61220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pv+/SOM6WadwPMuWgz9Fr/mgVJmK2CvLOtP9BpfdpCw=; b=MwGc4DS1a0uNDo809Uz/V5MWUC
	sbSEymFjcTvQL4N8KnJMjzToJ0OGURstJ7FehhGOXJfHUwE2E9OTDDq6xIIs5U95ediERksaTLK9B
	hAKscH6J1PDXUOK1VglPIihmAq/P5Z82KAK56FXw39iy2V+etnzpUshR7p5CKaIb/0DA3uTDP8WCx
	3y9Ba1dRIsSFOHbXtlsc/Yq69E+jkLDmR5b9bJUynxDfTle9aAOFWdHr2M2MLpLkUjUiDAm/CCROr
	x+Y8KwvjUgYcSSrfBnfBsgStwOrajaaWx3MtIvwW1O9lCGeG6bkm3eRCokrhfXtu9wErPZjAmgtqn
	I+XUdvfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwAUc-00C0cf-UJ; Wed, 23 Jun 2021 21:33:06 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwAUO-00C0Xz-0d
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 21:32:53 +0000
Received: by mail-wr1-f43.google.com with SMTP id h11so4213394wrx.5
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KQNp5IMse43OkEqE+mzPjQAcJhkyYGIkXC2qTp6ZlDQ=;
 b=NQ2u2gF0or/lFC+Z/W7cbIbMLfV7tbLx5TxeOTHiYPaQLuyJQl0JJxsHAiT2tY6ycP
 Rd7JOMcAiT1wDIoX4b/V3gnsPXANcNSuG0ATVj7Z5uOjTgl6tWHUnErBeMqf9yCj4Nd7
 hPs9eCQtP0MlHT3RqNWgtCv77GNBislmwzm7w0WKh0vLnFYiCqXb84iF3y90LArw4byv
 6KqBYweu5tRMWPu56UThlk3OnuzOTU1PpiJMhakivyHH9Rwjbf5swdgvGqwI1IsKlOwN
 bJ0llDFD0JwNN7P9WF0K6z5YhtUBbSyGLDC0KyFKqoJUbs7h+VsA47RBFoDrxbNeHsyY
 Wnpg==
X-Gm-Message-State: AOAM530hIcDxPIc2KPAMY66PKWFzIq3iNqmU3kJttlvEaBscWg+BA41C
 7wctI8/DqlDJnTUKWBummDY=
X-Google-Smtp-Source: ABdhPJzUwExWUOCqamnHQeG8Fi6g/8jDwAybW/Aw+aHAFxxd/7IPZIo1VGhAd0ZVkKe5EMzhf3h4bA==
X-Received: by 2002:a5d:59a5:: with SMTP id p5mr188596wrr.27.1624483969473;
 Wed, 23 Jun 2021 14:32:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7?
 ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
 by smtp.gmail.com with ESMTPSA id u10sm1024437wmm.21.2021.06.23.14.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 14:32:48 -0700 (PDT)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
Date: Wed, 23 Jun 2021 14:32:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_143252_107524_4C6C2F07 
X-CRM114-Status: GOOD (  16.40  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello
> 
> Gentle ping here, this issue still exists on latest 5.13-rc7
> 
> # time nvme reset /dev/nvme0
> 
> real 0m12.636s
> user 0m0.002s
> sys 0m0.005s
> # time nvme reset /dev/nvme0
> 
> real 0m12.641s
> user 0m0.000s
> sys 0m0.007s

Strange that even normal resets take so long...
What device are you using?

> # time nvme reset /dev/nvme0
> 
> real 1m16.133s
> user 0m0.000s
> sys 0m0.007s

There seems to be a spurious command timeout here, but maybe this
is due to the fact that the queues take so long to connect and
the target expires the keep-alive timer.

Does this patch help?
--
diff --git a/drivers/nvme/target/fabrics-cmd.c 
b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..f4a7db1ab3e5 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
*ctrl, struct nvmet_req *req)
                 }
         }

+       /*
+        * Controller establishment flow may take some time, and the 
host may not
+        * send us keep-alive during this period, hence reset the
+        * traffic based keep-alive timer so we don't trigger a
+        * controller teardown as a result of a keep-alive expiration.
+        */
+       ctrl->reset_tbkas = true;
+
         return 0;

  err:
--

>> target:
>> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
>> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
>> [  944.900051] nvmet: ctrl 1 fatal error occurred!
>> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
>> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>>
>> client:
>> [  857.264029] nvme nvme0: resetting controller
>> [  864.115369] nvme nvme0: creating 40 I/O queues.
>> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>> [  868.001673] nvme nvme0: resetting controller
>> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
>> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
>> [  935.438080] nvme nvme0: creating 40 I/O queues.
>> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
