Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66DECA5FD4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdudn8FwL73/QjaCpm/gp8xrl6jNLqAzbnCEEA/e7jw=; b=CvpibsTUW/Oxtye7gCKMtPSZHI
	9ucDTnLFAiZVKQhcgrY17Yh2y/cderNrcCpM3rm9iejU1Bap8tLEwdO8sFubJT68pBw7er3wcLhb6
	Nc+t+6w5VXF4PV9ZG9NyLGqEOMyWUotmR4rB0JgG5qEUnFdlT1PXfg3CFe1VEhNmGMnCSVRYoBWZX
	2+cNmq8CBeEMgMDxQOvq3tkG7V9xQClfUzJoy1Tb9NtsD22gKTADsAcu+WuGN0XaEZ2H4gIpfO6o8
	Q80U7QrNqTtwb4k4M25ujqS1Ev3X94usfI/hdMC7zm3JSmHZwkpNc+K0BPivrJdr03hv3uoS1L3hI
	we6s+uuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCcX1-0000000Bb1E-3Zye;
	Fri, 02 Oct 2026 12:38:31 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCcWz-0000000Bb0t-15FK
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 12:38:30 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912d8239so31245e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790944707; x=1791549507; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tdudn8FwL73/QjaCpm/gp8xrl6jNLqAzbnCEEA/e7jw=;
        b=YXO3E5wkCYYaxyJ5chtTFD9RYMxTpe24y7J4YrTixeU5e9lv4MaZiuY/D80LT9Xirg
         npFOHeZPc6v7pmIgP35oYRGyk1kKqmKO3zA+G7zteEY4iQs6ccFt3z7N9jBXuZOWZpKc
         +o3gkYqHDvPktqHsqyPV+PDau7wQ9H4OZ+iloPH5CPiKcE1ECeUh8n+8oEk83K7KV6UG
         dLo9zhnSkeTI7TJsY3ejc5l2Ce8PF6AfxNXqSqr6EdjNpDd3o2c0ST9vv6NtsvzIM3AY
         DiJBh+AV7pjFatKneihfs+39UAeBjcePBx8Gcg4WHx9qAawxrpSFOWCp8fF/4N95DLGf
         0NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944707; x=1791549507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdudn8FwL73/QjaCpm/gp8xrl6jNLqAzbnCEEA/e7jw=;
        b=1MxskDXrtT3WvazPMQk401UuWMkiuzWSxkBkSf9vYoKCfnBOcvZ1mh89mItdW/258F
         TJl74g1coFHINk8HJStJlBAFH9BLv9DaUM1cmrao82k4UzT+1ycOqSq8x1ZfeelN6ucx
         6ybKnclLMN+ezOeWIgMBXBDa2w0xmNVzgMHSrNTVEjsqVyvjBi4LKx5lntCja2vaWN8t
         AnRoswSW+NFsj5+li8hZkce2XzU/fh2HAWt/H9cUs5SPY9ajx15C+2UUe0++FpMitJwY
         wy8ACJ3VXIgSRqGDE43Xdzeclp6Sh3y80vNj0LLOo83aeeFszf6Bz7EXAiCovB5Y6acL
         ZFEA==
X-Forwarded-Encrypted: i=1; AKwUvByMhx74+gzMnkvksEeY9Ldp03R3u6IcJWQNoOdxfoxSsjZTBUIIQA2gphaxTzMl65IcrSm1IV5bp18i@lists.infradead.org
X-Gm-Message-State: AFuF++k5p2IpTdSJWA1ruD61MMdTbObRXIAaois0UmyVF0AmzNATlVMU
	XTsWsISmNaO/X3K6uONo0EbhaGeFOTccUiwyCR4kUIQVF7/HeWfppD4RCo2wobmNYQ4=
X-Gm-Gg: AYBFou0IyTZiI3vFgeGp/GfuGW5q9g5dV+hVl5T2pmXMkFPqKwcNGUnwNn9BLXvoXrP
	mYNGqvrH/oYH24PwLlmT/OIRADoNIwWcX9Sg22r1RBq+8Z1YUEecn7WeVlyWNOQDgnbs89LCRDl
	BTAvKdxarDERJaYDgR182M9vi8Ac6qJIT6SCZf5l16gVbXBchwDOSeEXLJ5PHuFPIpF3IWgduJu
	WTReEywBpBcVKVZjGRnVv6WRlC+KvI7WAz3h3EcnHPaBOF+ZINEX2pd2vSxzqKtNr5LZ0fJyYxh
	pAuJW3gi4D5/mstoKr+nYT7AW0GejBQPkT4b/BV6DncWlt8zEREBkqR4Ku+j+4GeY1dEwdFxAO3
	iGXODE+1+mHCW5R/OLQuMKD0uu6CvoeOW9pXcM9BIN6++EF9y8qJLSPlD/osrwUwcmvo4cyrIre
	TgBYDoh2yssH9myLFJllT3Ycq7p7qciBcRknFPAJBQ+CJaiatpFoOMfh8+HY7Ex5M7UbCVgHKdf
	gbmJE5H8cNInhyZjPKp9V6HBEbNzsDrEUU=
X-Received: by 2002:a05:600c:b8d:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a0276b40a9mr42445835e9.33.1790944707389;
        Fri, 02 Oct 2026 05:38:27 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1662fbc9csm24415e9.3.2026.10.02.05.38.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 05:38:27 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: nilay@linux.ibm.com,
	hare@suse.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	saravanand@crusoe.ai,
	sjpark@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: Re: [PATCH v4 2/2] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Fri,  2 Oct 2026 05:38:25 -0700
Message-ID: <20261002123825.32384-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <573b1136-7fb1-4457-b5a9-9ee07e0c07ce@linux.ibm.com>
References: <20261001094857.74567-1-kiyer@crusoe.ai> <20261001094857.74567-3-kiyer@crusoe.ai> <4a4e228f-7143-4d5a-b773-2c6238852503@suse.de> <20261002105612.25298-1-kiyer@crusoe.ai> <573b1136-7fb1-4457-b5a9-9ee07e0c07ce@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_053829_311230_70A41536 
X-CRM114-Status: GOOD (  11.14  )
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

On 10/2/26 5:22 PM, Nilay Shroff wrote:
> The earlier fail_if_no_path name came from the dm-multipath policy, which
> uses the same name for a similar use case. However, I agree that
> fail_if_no_path could be misleading here since it sounds like the inverse
> of QUEUE_IF_NO_PATH.
>
> So I'd vote for fail_on_ctrl_loss for this change.

Thanks both. We have consensus, so I'll send a v5 with the rename:
the attribute, the NVME_NSHEAD flag, the ABI entry, and all references
become fail_on_ctrl_loss / NVME_NSHEAD_FAIL_ON_CTRL_LOSS. No logic
changes otherwise, and I'll carry the Reviewed-by tags on patch 1.

Cheers,
Krishna

