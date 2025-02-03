Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ABCC02194
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=; b=d82DqzCBjd332/KcCBd8vElt+L
	2Rqa94li1Tfu2wqmE7lrs8kkgMFh1ZmlxZwRJZmcGmSCo/SKEF283p8r9bBXzobkzUorBEMj7cTkC
	YMGYBjUTU5avmZWnTRqvE9XEtMVcO/yROUCl80j50nJjNpARrp54hkKkb+AqQRL2EY5f/a8FQEccr
	cPpTm+fVdzSsA/e36pou4SUv6vXK73rees9K99fL8ljeOrRAueZgyPbTQAvEBsEfR7CzRJVH6FluJ
	HfnZ49kELCoHThUo5Hph0niOgzQx/NtGWS41aDLVVHBhGr5hCk2huQvue+Sh4dhTPwrkD/oowVEYY
	o/AWr3Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1texPL-0000000FfRZ-01TT;
	Mon, 03 Feb 2025 14:26:39 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1texPH-0000000FfQE-30fZ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 14:26:37 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso967060566b.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738592793; x=1739197593; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=d5pSsG8dRbs2Tb5Y3feIwEpCipQw3cdTGb9CbYl69oNDUaOUwibtiOs2citWcogAus
         QS5Wqv6LcljptUm1QQaLaPGRWRr15hCazCO/LiKEoYuT8ElQdLvIAQZgrE0Tu2Vc+5Nk
         d2NEyB8fTepZtSDUu4Nmzcr5XYsPLk8D4vanXWUmbzfxrJ2XRlKPsxRoeospvY+Ewpam
         /wzutJgOU4/qYoD+pjbYpoZgjbPguzDyYklMa9xcG3rjVLYA8c1eTeHKav6MrJ1JdRaI
         6XSRWK7tIru+GuFz9PFLzsjLtL1Vreq7wqi+bzBeNWM8+bozRf9PauaqK9YkVDCma4O/
         FgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592793; x=1739197593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=GUqOxUXsfkCSbaZoB2GtJTJHeD+ovWkcGJKjFhYIYNSCwkifjGOe7e3qDwB2xHu7La
         IZVcXVxNOI5mjKRj85LBIptGuJzUEV1w8kPicusWp/bH8hnKQissXNDtHs1Ms80z4tc3
         EKgF89aHiSzS5WMOx28AE+AhRqcgQL7oRBWkmjYKwqZmQ2j0z5zk9u+wN6u3shcRABwA
         YkTPFbpUiP4wDE790Vkntfk6i8/QJFURo6tWFuc7USricTXJDVmM9/YQy2l1hS76oUuo
         DMxTdP0ufYLRPHciqNLqQYIQhEqupMtYGFQ9WtXRKv+P4ZFVRLwxxCtERbpTvq3lM/dc
         /3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVvaDMqViojCuKw19NQrsaaFi7EF2fNAWMgRSyfK3riF5jyaY2RFj6glHAKPoPfMC3SZf9Jr9YtAoWl@lists.infradead.org
X-Gm-Message-State: AOJu0YxWuxTJcTzmasigSmXi7Puzc9j9q/uwdQQK2Y4zQSxEB9QJ5t8+
	FU7ILSX1RjUQyg512GSp8nD3I43IK4ETsp7bSBhN1GHYDSzGWlgZlsioNq8Tnws=
X-Gm-Gg: ASbGncvFOlNK1b7WKzB1ApJ/CzmWBUxdU4d3T1DRKbrGde+GHaTqe+dNqezF/PRwAgg
	lUb7t9j7hi1JFl2X8sDAkp6RFl0A5JHiixbowfStg6uDLsgfbIfN2lB0LafUZjxgw9ysfFtgYGU
	ReR+Z3kjCJdCtuFfufeH/UHRJeDXNojeB4SEmgzu5UyutET0SgqAAlSfYAIopRd2/zPs9wavdVS
	xj8qNd+/o1XvW+U+fXJtPU9un42VNBeU+j207zdBAbuB22JqPoc8ICAno42YnbQPBl1Nqwa38Yp
	6oEUUA==
X-Google-Smtp-Source: AGHT+IEMvqFtWMQcGcbew8g5CbtS87OK4kOUrbaUT5fxc6WJnZS+Qe69TNruF9V9SFX0gjEEIeYYSg==
X-Received: by 2002:a17:907:6eab:b0:ab2:ea29:a2 with SMTP id a640c23a62f3a-ab6cfe11e85mr2509321666b.48.1738592793317;
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab706ce9a53sm509134266b.72.2025.02.03.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Date: Mon, 3 Feb 2025 15:26:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z6DSGOsqjw1ahIYi@tiehlicka>
References: <Z4pwZkf3px21OVJm@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_062635_757893_6F9F8862 
X-CRM114-Status: GOOD (  13.52  )
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

On Fri 17-01-25 15:59:51, Michal Hocko wrote:
> Hi,
> this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
> find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.
> 
> Please also note you need to fill out the following Google form to
> request attendance and suggest any topics for discussion:
> 
>           https://forms.gle/xXvQicSFeFKjayxB9
> 
> The deadline to do that is Feb 1st!

The deadline has passed but if you forgot or this slipped through then
no worries you can still apply but please do so ASAP. We are going
through all applications these days and will try to send invitations
ASAP so that people can start planning their travel.

Let me also remind that all the topics that are to be scheduled should
be posted to the mailing list (CCing track specific and lsf-pc mailing
lists). 

Let us know if you have any questions!

Thanks!
-- 
Michal Hocko
SUSE Labs

