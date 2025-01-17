Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD717C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=; b=VPiOl5rzsayv4hgCCeIEUWzZ/+
	E4uK7LBdTv/FBpWSyylDSUQ3DIEQUpbFFBR8pxhrgtu8A5ddCLOXj/dGcI+GCGpTtsjCcrs/UIEkb
	jnwoNbvrTwMWoDdRSN+9+yWCI56xfAczW3Dtf9cRuKHuFhy+6nXIOT+PoiQBNWPRQ7uyLEjQeDeQ5
	3awDRCAZGjqF2y1KPZ0ja6mo7SSog8izJob9zF3CXwcgTs+q+73GYn6cO49pVVKjmkEDRcHx9v3gD
	poLixAec0H1/wtjdmfagKVupF36BjHMZrCva1GBMSoJDuUSTS1fdR58JR6MA1S+mmCGiesXCDf9f7
	DjD5tuFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYnpE-00000000Y4f-0ch2;
	Fri, 17 Jan 2025 14:59:56 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYnpB-00000000Y3z-4AQv
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 14:59:55 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1172002f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737125992; x=1737730792; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=OMnbYeT42P0itQu+OxMAtrvZSAfWx8ObSdiHBZDVDZpQ94I6MTWkgd3Excb0gDTcVw
         NyEz4Nwk2P07Avr1wXeI5EVCVX6nbYoznRT9xfGnxI4zdVtlFfRGzd9u+64HByXJQf02
         Z14B5b6PbBfgI1/XW+5+tJP+FSOkzZBJ7mzdjhvfrxYUKgSzdjzis5QJU3agR9bgwI5w
         bHzfao11wkZU3Tvi93j/6qTnKhg8zvAPRMMWpTrhm243+bPdYvfJyauWKkGGmB+kuNHP
         CjNq3YM+3KfNSJkaGBrQpfmjJakI6F5TS0fv61lkPhUQ0Q58ZKPWCsfFQirRNyWaqm1/
         0qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737125992; x=1737730792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoY2CmYqDhwCjr+LTaQT1CEx+jVsjk82eanBRDuR1qg=;
        b=Vn2ZFbseitk+2/sufR8TRt76uq48WMK+HZDlx7TxRSAz7j6L/nMTiyneiTOf9SMYS2
         7E0AVw7KVwhbXiQgFiCbxjLiYwHt3uHgwc97c1EPrzCes4HsKZCSHmg9wyThmXYM30rQ
         OfniAZyqBDo0mtxh8N2PboNrafMP0IDNJcXrDD14G6yiBp+cqIQ8myFTQ9D7Z4pkTE8K
         jQHQP9K2ZAH5ae5BwgbFFELy4iJ1Ka8CYX6JYnvCLcyseSJAIf3+P6WJKg6DuKUy6cTI
         KRSDyKuYUfir4m3dJs53+i4VrDKdZWs1Y+M2rPHmH6Drq5rmebl4++uMj0+drHRaPQSJ
         MLMw==
X-Forwarded-Encrypted: i=1; AJvYcCWgysgNmEmKFuJNWgTOFZXkn4JBVpeV+t2JIKq48JoU5aO/CRutvaMnBEvBWu7PS0jha/I+kT10Io2p@lists.infradead.org
X-Gm-Message-State: AOJu0YzpmcZe4AtWjhQ8orduU6DUM256XRuLC8or1kyasa3zjP+jxe8j
	Txl8ZN1VGT7M4jQ5Mu+Mul7yYWvkhd6RvDqzv1TlALigjvF6NJXYRRbIh66rNwo=
X-Gm-Gg: ASbGnctAkS7J6cJtRESYUMT08PohuOcp7Yke24k4fTPhlEuWkZTQCa7HEQ8852qx8aa
	sECpkvq5NLrWI2vw8RuFAxPctlabHq0AUDVkt7ZjwjsaJ00lDSFGPfOk/i6cOXEGZTrArK5q6QB
	j3BUPO5dSChWhWMJS9QEX8fOBlWWDz3QUbvJvvW2i7uePGzBBfQXQLx55pt6L3ASJuuPeLt7UtZ
	Frb6/y3zIVJDn4kiAznKZ2kMbPfpIdQpfObekqBOvQTqEtmFFH+LN0TbQS44feuRUenmw==
X-Google-Smtp-Source: AGHT+IEeRJ9cpKeNPyOpv6YqDFfsJM6JExhw0J3WkruNYdK28qTCi2QUozVixRXMXz9wRrk9NPLQtg==
X-Received: by 2002:a5d:6c6f:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38bf57c070bmr3026621f8f.51.1737125991738;
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm2751940f8f.72.2025.01.17.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:59:51 -0800 (PST)
Date: Fri, 17 Jan 2025 15:59:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z4pwZkf3px21OVJm@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_065954_032299_55A0B9A6 
X-CRM114-Status: UNSURE (   7.94  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,
this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.

Please also note you need to fill out the following Google form to
request attendance and suggest any topics for discussion:

          https://forms.gle/xXvQicSFeFKjayxB9

The deadline to do that is Feb 1st!

Please also note that we have decided that there will _not_ be virtual
attendance option this year. Nor we will be streaming sessions. We are
sorry if this is causing any inconvenience but we have concluded that
we will use our constrained budget more efficiently this way.

[1] https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u
-- 
Michal Hocko
SUSE Labs

