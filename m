Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DE1C83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VfxM2URcquJpqnvb3+mANnD+/ukwwGYDl4TruoTMXok=; b=uabuoiLOrLtHkF5eCCmwdYSlpt
	7BfM2WSm30j51SsgAbCqVk9emPC6oNEVzwjo2CS7wgxVcZp1j3CKGw+y1e0oCD2nYt7oDQtjigjFz
	Tx9ye1hh/tbeaB2laGI04j7kcV7uwF/cuwuTyU8zFlXU430KnFtF4JVC97arJP14em7/LIOQyyDQZ
	B/Hsvv05xovyYQ5PcKYqLaolyKHovX3gnykbY/SuvfVtUIrGNW1sdenTwYGfYWfdJ2k78cGzhUbmA
	RyzaNk/ymfZ3C6ZqraEP1GHVV145oUDOW61XQgKOiwqKlqPT/e/kN/HC0RTQQwMKY56QT/W/QKrQ0
	h6Mq5EhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaBC6-0000000EVQZ-07Sy;
	Fri, 11 Jul 2025 10:41:30 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaAHN-0000000ELzJ-1gtg
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 09:42:54 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b34ab678931so1454042a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Jul 2025 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752226972; x=1752831772; darn=lists.infradead.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfxM2URcquJpqnvb3+mANnD+/ukwwGYDl4TruoTMXok=;
        b=ehnI39DEgJZuTP0VrPngGpczToTQCzCQKlpAmtDtn+Ncp1xyf2sS4wrdMzrSbvoYtO
         uRRjmTJ0/X0NPC3lI9joTpUTfwso+GaxpmYOfYOxFvpG7+wLEkfv3herS6pGQVGopCZj
         aOROaHB1iRdya2lbtiH1XUUKbWT6iqEgMh7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226972; x=1752831772;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfxM2URcquJpqnvb3+mANnD+/ukwwGYDl4TruoTMXok=;
        b=kItIyjDmzyCUbeKIkxDyeQ+UWmV53JxSAUrFpnfx794qXMYWdG+c+CPjAA5vVBCPxJ
         W8IZxv2CuX4JYtn3v+9i/NxS/Dl8wTZjyS94Qyg9IU0v2QWO0B8jzRqLRKM84gC+eLBS
         4lGAU9PpZawuSs4kSVDwK/FFqi2SvOPqE9M2b64tcz+yKW+GDFZliX6XDvbDlfEVg68o
         bmL4YYgS2GN9nF07lGJsQ8ZLd6YQmkYKzznt21uCG7qtcrFX4Ru9BNmu2K1RRfnuycKs
         Auj3a0itLxqDQm0mChkuoyn2nBpLtA75BYBh5/8p/EISPjGLLJLtzdLvayCjoSUje7/W
         URtA==
X-Forwarded-Encrypted: i=1; AJvYcCWerTHNQv4LAF/RAF86Nle7OACcu4wXcZSmcQqLJNqHnDPcrogpkR/yi4EL3vpSUo8f79+9LdS1pjHe@lists.infradead.org
X-Gm-Message-State: AOJu0YwxxWGsbtWk+gEucUfKcNsEc3C10XhtN2yBzkEQ1LUcDlxU1rnZ
	veYz7ggRFEaAjeU18/ofncuCvtrqDxPGFcsLgRvgEUCqJt3TJqLhoksMwNDI09YqlkpLUwSuzsU
	agIrh2Chm+z8obBLh9IepuoUR1saXmYL6LpjRzkXeYNIzcnKqzjGxeC6pHw==
X-Gm-Gg: ASbGncvwlg4TZjWCBEaBOJpikcFvSrQHsPdnxOlX37FzjhTgWPbB8T5y/Ns6cVevPpI
	3gRXFuik81FGq4vV+SRfj/5Hf7xGXMIhBrfm68MC4Oo/YzydkwiLuBquYRmLk9ElpzFdG1mTiGz
	43b4ZJGCcom0U+oMWJEjsT4U/rW/xuF0EFtHXwz0VgzX2DjRWoH1Jpu6LC3SLMMI/GI1chTBxeY
	eP+Qo/SWGNKYrNWI6G3wg7jdDUEkzcFemUqGCk0+LkyTArlnmoB3QPfZ8LY4Nm+UNaRsiuqYooD
	IYVyjG2Loi1IPxJ3nFCLFAgbpEfsDmg/vBJatcCTTiXbpgnIw5rPe6loobC0N+AN6UtZC4UoRDc
	C1ibSDRib8mgwwB6itITychzL6uNJXk+HKqPN7Q0m9ZhvvDRIgpDB1sPq/deQmWelDpiT4t3tda
	B7YnbA
X-Google-Smtp-Source: AGHT+IGm3ziFKwBeSmcyN3il/RxWPJpQ9gQIeSWurGWOmKmZGOROcHUyFJ9hAmY9m8N1Q0l6qqjWLg==
X-Received: by 2002:a17:90b:48c1:b0:311:afd1:745b with SMTP id 98e67ed59e1d1-31c4ccbc409mr4086739a91.11.1752226972506;
        Fri, 11 Jul 2025 02:42:52 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43411c8sm43605745ad.184.2025.07.11.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:42:51 -0700 (PDT)
From: Muneendra Kumar <muneendra.kumar@broadcom.com>
To: bgurney@redhat.com
Cc: axboe@kernel.dk,
	dick.kennedy@broadcom.com,
	hare@suse.de,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me,
	muneendra737@gmail.com
Subject: RE: [PATCH v8 8/8] nvme-multipath: queue-depth support for marginal paths
Date: Thu, 10 Jul 2025 19:59:25 -0700
Message-Id: <20250711025925.1831977-1-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250624202020.42612-1-bgurney@redhat.com>
References: <20250624202020.42612-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_024253_442521_A4F0026C 
X-CRM114-Status: GOOD (  18.89  )
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

Correct me if iam wrong.
>>. In the case where 
>> all paths are marginal and no optimized or non-optimized path is 
>> found, we fall back to __nvme_find_path which selects the best marginal path

With the current patch __nvme_find_path will allways picks the path from non-optimized path ?

Regards,
Muneendra


>On 7/10/25 00:03, John Meneghini wrote:
>> Hannes, this patch fixes the queue-depth scheduler.  Please take a look.
>> 
>> On 7/9/25 5:26 PM, Bryan Gurney wrote:
>>> From: John Meneghini <jmeneghi@redhat.com>
>>>
>>> Exclude marginal paths from queue-depth io policy. In the case where 
>>> all paths are marginal and no optimized or non-optimized path is 
>>> found, we fall back to __nvme_find_path which selects the best marginal path.
>>>
>>> Tested-by: Bryan Gurney <bgurney@redhat.com>
>>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>>> ---
>>>   drivers/nvme/host/multipath.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/ 
>>> multipath.c index 8d4e54bb4261..767583e8454b 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -420,6 +420,9 @@ static struct nvme_ns 
>>> *nvme_queue_depth_path(struct nvme_ns_head *head)
>>>           if (nvme_path_is_disabled(ns))
>>>               continue;
>>> +        if (nvme_ctrl_is_marginal(ns->ctrl))
>>> +            continue;
>>> +
>>>           depth = atomic_read(&ns->ctrl->nr_active);
>>>           switch (ns->ana_state) {
>>> @@ -443,7 +446,9 @@ static struct nvme_ns 
>>> *nvme_queue_depth_path(struct nvme_ns_head *head)
>>>               return best_opt;
>>>       }
>>> -    return best_opt ? best_opt : best_nonopt;
>>> +    best_opt = (best_opt) ? best_opt : best_nonopt;
>>> +
>>> +    return best_opt ? best_opt : __nvme_find_path(head, 
>>> +numa_node_id());
>>>   }
>>>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>> 
>
>Hmm. Not convinced. I would expect a 'marginal' path to behave different
>(performance-wise) than unaffected paths. And the queue-depth scheduler should be able to handle paths with different performance characteristics just fine.
>(Is is possible that your results are test artifacts? I guess your tool just injects FPIN messages with no performance impact, resulting in this behaviour...)
>
>But if you want to exclude marginal paths from queue depth:
>by all means, go for it.
>



-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

