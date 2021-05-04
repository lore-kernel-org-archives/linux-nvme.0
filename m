Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC26C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:01:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6914F611AC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6914F611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=jxfq20sUIqGGnwbIbsPlNMfxw
	HoGMu4CuvsynnbCB5SBdY3c7TJBYak6hW8rqoUlvTqdOFwVlblQdfsyC6UwrVtnhvLi0vGccaAav6
	WD1CfkbVbKMbO+L5jZp7pybSe7AxkcXPnuGnf/1JJwl02Fwl+7p49uqBYE+zzIzIou9X+Os3YBkD2
	9e9y2G6A20DOzkcbd9W195IgNzksNfb4PsGEI6TSLQKVBpjVtSALxJ8/MjjM5zKSKe9OiKn8nrrrK
	qv2TdvJsEFZd2pbxkOENwl0n69/rn3EFNBPv+Ye3ik0JcA4ApMNZhHaeEgTiX7Ov+z0BlGN4QQEu4
	MTjfj33wg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le1Df-00GyL6-5o; Tue, 04 May 2021 20:00:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1DP-00GyJt-8f
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 20:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=yOELkUEfVH/W1VzTChApWq9KJv
 mZCMHBYqyWSdpBd+c9pFEsJSyuYJaxTJF9VE0DBkR81tTPYOb/VGGJ9X7xvdb4jOZhK0d8K+n6ShO
 VLwtCMGalEZaVmYD+XATau+EhWz9R36xmYyks8ID5bLXTBM2e/p/W0p1drGcIaZ+Ye7PzsQNvtrOA
 alT5rGmvQhDPfjNX4FgIU+Ps98IbaV9kDnjYLw3aFsI4+Aerw7CpiXdfHbBSoWouUeiDMYE7aNfH+
 Va7yO4rkYAYLju9QxsS3J0GoMbVzZXfV/Uo9Vu8xcG3tOQ3EybjUV1yPdiu4pHFcDn5JpoTzOkYiW
 KmCogUbA==;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1DM-004Ee6-LX
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 20:00:18 +0000
Received: by mail-pg1-f181.google.com with SMTP id d10so8605816pgf.12
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 13:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=U32PsLiEKHJTBWW+NQOtcaC6TgIo6dQaEUnQB/snTIDoCyIUWBghMuOQ0FHkWHZKlB
 gbKvTXKjEJUXSlVaSLlVmin9sMODKhoWz7fposxowatMLDrsimsHFzYPWfUoojisD7L3
 ggIMbgFjswCCodXwWW/x9sWY5cX6DrdXRMn3yXdUxEP80l+zFlUGvEqEv3uHKFSUi+E1
 iSw28Q88RAjTRVTxjoIY4ZMYhLr8ecZLECVYQxNebQJm4mUmKDWzyyYxh3YDHcInRisT
 1f76i1yxchNkjh4fbVInvjsl4SUfTP4oi1NvnuHeodJwAEENHtXi9U3VIJ/v9Q7/qUw9
 sHzw==
X-Gm-Message-State: AOAM530kbf0Vc1vqLhKSKxaGId26LKQiXY6vAh3n7jK5+oLzzfuM7byW
 HhOmUXauOmwdxFgL4XlHqkJ2biBiD3s=
X-Google-Smtp-Source: ABdhPJy6YaF8gGMsYv1XDnEHSoB+GfbWCX2vTmQyDaAFrF2V033lVDczfPEIXH7kDzWKOvO6oPQBGA==
X-Received: by 2002:a62:2901:0:b029:28e:ef3d:10d2 with SMTP id
 p1-20020a6229010000b029028eef3d10d2mr769722pfp.45.1620158415605; 
 Tue, 04 May 2021 13:00:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id q194sm10360477pfc.62.2021.05.04.13.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 13:00:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: check sg_cnt for inline bio for bdev-ns
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
 <20210429184357.9185-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1172892b-5664-d348-d407-825312dd2fec@grimberg.me>
Date: Tue, 4 May 2021 13:00:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429184357.9185-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_130016_731777_607E124D 
X-CRM114-Status: UNSURE (   8.49  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
