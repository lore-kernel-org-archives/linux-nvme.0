Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0278DC021BE
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lOX0SElUTAPhTDEHrkV9MlHFa0AQe5Pa2PVDVGKY0tc=; b=Jynl4MlLQP/b1/vJl0U7+cNIev
	49xFcDP3KX0gGLb5ntcjtCnE1Kvu3IwNAoaNJHeUREgT7y4u5Mw/q8Fy2oTp5ACjDtFFAFwDP/6fi
	BHQ4/8ifVDyZMy4iNbv/VpPIBl0HveSOCfibFZOHBuXv/MGeG8lZlCjYmlYVx5l04BxigRaH1uFkA
	jg8TegmNho8tI1AAM+1APGPMOU7myxYWX+84r4QMYSpig8C+gDwznoi22cdIwD4crLhCkPGe4XAAv
	eTNG/2uAwR1jVfIGIA/S+lvIQxf82JPrNC/gqMDXUV+QdVwKmWxaUQ0JAjat47Bv0bM7CXOrnR1Zj
	Ue0P3hdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmyLI-00000000WOp-0mS1;
	Tue, 25 Feb 2025 17:03:36 +0000
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmjWy-0000000FgT6-1PdL
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 01:14:41 +0000
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-7271239d89fso1480025a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740446079; x=1741050879; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOX0SElUTAPhTDEHrkV9MlHFa0AQe5Pa2PVDVGKY0tc=;
        b=QCmR+rcXnPISFRnXtBLKZ30pQ+dzynH8KGhlAQuWuMvBlfzbbpSAEHNIJfLj9Q8hmn
         FOR7oGg8DbELyyWlzDYMCrmgG20RqdjrciRX7Mu3UJhreP8KW3f8xXx1qst0PLPSIspC
         5a/Q+3BxUM7l4aLQTM7fTEncTM5Mr1Y8/Z2IUEM56HUL0h+IkaqUcheVy7YUjCC4h7YI
         +/wqizbijdeQH+g0GeeVwRALkpBkijHUEDP/SLVE/nMHqQs7Q47vYIBCVCHT0/zYIwEi
         YZ61I50Ls+1v096j0ucKc1fxLjjQlSBOeoYwuwkw7FMgOyQCWowjv3JwPiPq4LH6BRl9
         A8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446079; x=1741050879;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOX0SElUTAPhTDEHrkV9MlHFa0AQe5Pa2PVDVGKY0tc=;
        b=Sp85EaMBrc8Pwt13jFfTvbDo5LNDzrnJ90U9I3a0Y8toai7UfiroPB4UL6OovK/mVE
         1hEP4TBuu963Noj6OHOg2DXcGbPlYCHa6lPVlYAwzM0zC2xMlTkxTz2DerDDnZ39maMJ
         u4W3OFSkWYDOUCGI/f48nB1XloYIDmZPFUrpTJL7T0StxWl8xNfkishyqGVOZjloMM0S
         DBNIg9VxoPuLFNc0o66mRwGF16KKHUfafAqKuq/fTQsnsjseDXNY4sPMRT/en8lLNlL8
         fP129pElvs9a93mGYmhbaz0rZxgEGzSbDR8NhAMZp5SIP33d4huvxOpyDcipMw2gGnWo
         Bdig==
X-Gm-Message-State: AOJu0YzuC/lLYGVpiF9gHrPEpddjSktT+NisVynkaoJF92gUEtxVsLKa
	KUcpZ63IjwMHa4RHZEDL+spiM/YwHDSBWMQOJJqa2NqD435EX6iW
X-Gm-Gg: ASbGncuot7MWCWCaizwmIdLeezgNPxPuQ50TYerat4tshbTVNayy1zCnGCy+wYVxWiN
	gnkAbfSHpwrUpUBEIY4Qt56xahK1aAsSrWC7KVgivXG+vAP3iGcXZ5WdM4GdCreQvd3anLoXgE6
	VJ2tl4gWKU4e2UtKdUWfkcWDUEolS7ae9zMfo0YJ6OyTdGlhqYpSzqe0ThLqBYgFF+iTIpZK9Sy
	Q4UJLtjrszn7bwfUBxu2Mt78tYGPNb20HI3dhF0fFt7EeAkMcgqJyD5lHs50RnGzBhTZ0weW3O0
	gMJ10qxM8hKpJW8Plz2P+XlJ/eIu2pYsBr2QrCxL
X-Google-Smtp-Source: AGHT+IHDl9DFe+k5/H+CSBCGag2LugCpj34v8XQys/QEF5MouRrE8QDx71m7Zc7Yy8b+0Y530L8IKQ==
X-Received: by 2002:a05:6830:6304:b0:727:35a7:7bea with SMTP id 46e09a7af769-7289d17af89mr1395358a34.19.1740446079200;
        Mon, 24 Feb 2025 17:14:39 -0800 (PST)
Received: from [10.69.48.50] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dedfd1esm108003a34.18.2025.02.24.17.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:14:38 -0800 (PST)
Message-ID: <c56be86c-c539-4e34-bd5e-aebb2227e932@gmail.com>
Date: Mon, 24 Feb 2025 17:14:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qasdev00@gmail.com
Cc: linux-nvme <linux-nvme@lists.infradead.org>
From: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH RESEND] nvme-fc: Utilise min3() to simplify queue count
 calculation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_171440_398642_5782F0DB 
X-CRM114-Status: UNSURE (   3.71  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 25 Feb 2025 08:58:02 -0800
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

Looks fine

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

