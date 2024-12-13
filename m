Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B9FE77180
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1Sve8pnwBIa0k3Fo9Yj0biS11b57p46yyg7zp7DqbGE=; b=X8xrdf8w3c12XuxDqjBnRbk9Ue
	twnh4nxNlocrFNez7/TUDRztoZiDugnWUsJfCr0XTW3AHaK+/y/e3ggTp6SMy9Jf/09CJaw8z0Bru
	Ww1HZ/dGw5MBYUmIjYAE38ow9UVKsLXgLEwjq+MjVYPM5TzeZKKzjeuwenBKdaaQGzikkpT7al4G+
	prEc1o3KkThgnHlK+4CBlaZnj106N78lLButNx3vmzExbpRxz7hmCwbv3nNcQa8WZ/HDKxddAvE9X
	OtlWsVXz0bMxsu/sDcOK98zrv6Cz6ek+4KGuh8BSSF6/mF0uf75Yw1/x7xQrIHC4mcnWBJt5Vb0LX
	Nav7SVjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3BW-00000003T1V-3N25;
	Fri, 13 Dec 2024 10:46:14 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3BT-00000003Szo-2P1C
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 10:46:13 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso16180475e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2024 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734086769; x=1734691569; darn=lists.infradead.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sve8pnwBIa0k3Fo9Yj0biS11b57p46yyg7zp7DqbGE=;
        b=IGKmaY6RknXrskD2KIygVoJRQ+1i7ZTSIxKN49CbiS5egOfKDn/XKEn9Tfq6PJOpt2
         vRJyMIHKBXLKrdVrbwCxBeEcqsNInWeTHADazlEZy6CwkJYND0Yvf+52Geqpe9SxXV/S
         hMBMuoQFNgxige+CGYOMaaqtnpLNDWihLmolr7eeWN6jOc/Ayief3PNODBiAPzkMQqHb
         G7vWlI+V1FSU2qowlIoShPmMNca1clcGxr7FAgkyE4wFPMX8AFhLafXsMHr1arDAYdrO
         bP+3MDtePQppInmJ/2KyOcqT0ZjgqaIWTWjK19Kycm+f6FR0H3ObAkAVALPRE7uiWjtJ
         TSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086769; x=1734691569;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sve8pnwBIa0k3Fo9Yj0biS11b57p46yyg7zp7DqbGE=;
        b=nk/KU+y8OcYH29V/3jaw0TVEKEKmFtouVJURE66z4jkjQZU8w0bg1KpJOjjbRxVV3I
         RY9ddzYoqb7RSHXOQ7S86IA4t3eITdrLwEATH2zRG8tde6wLnAF7CwK1bydffC28qJsc
         2ZEQW1xsSHo5ZozVOnPHViMFfy+b2UHe+neB6dgEt/NfL/bAPGnPP6vb2l3RV2gP5Qta
         FsXxxuGNkLOckaXQlZUWAYMo4tWX8uTgP+MauLlZDkix9AXQkSyH1NltmPyD/vUjD+nb
         BA30jtRJINFURdWZwdrFUR3rNCg4ToV/oPq8HwHdwbKVWXO6x6xttDvbLTHdKtSk7GE3
         c44Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeiETzTSoUzTIMzKk6XZyniuhXiew38LOyIpY9OEIazXQwACk/MKRWOsmVoF8oK1XGDDA7CHYb1Dat@lists.infradead.org
X-Gm-Message-State: AOJu0Yynfu1xyjsx1a0p6wBsTtW6KPej3zZFcfN/38kRoGl0Lto4c+yt
	yg+uKVbi9Sf21TWFvpyZkq30GWrT3Lds99kTl/+ZCSD4pG7QEo9XmHmUp24SHdg=
X-Gm-Gg: ASbGncvonfvBg1u1q2YI3Un19T6sHnEekzd0tyjfAURgEjDJmpGFJB2Nv1lQbgq51if
	ng7sLY2+fSY4Z61/gwn2dZWPr28Ak738GZf3/ry6cxriRptB+n2VCvC/ldZxZmldqNyj6I2WlLv
	jc+t+guzrlbUd7tdclVcovZdT99tdlmweBYDe7sFTz8MR3b+wnEUwM1Oq+/6RQGJym26BRKt6/5
	wwte5olQhyIOSxbh4nosuqrSMBTGDCa/JImJQ3oG8uamlY=
X-Google-Smtp-Source: AGHT+IFwOoZpIuq7JwkqBKBUH1jKuHJePdoKI8a5nIlR5OcswOlr6jGLXfryjmtIfeJ9smPPAQIYMg==
X-Received: by 2002:a05:600c:154c:b0:434:ff30:a159 with SMTP id 5b1f17b1804b1-4362a982c34mr18289725e9.0.1734086769544;
        Fri, 13 Dec 2024 02:46:09 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255531b1sm46569255e9.2.2024.12.13.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:46:09 -0800 (PST)
Date: Fri, 13 Dec 2024 11:46:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z1wQcKKw14iei0Va@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_024611_611308_726CEE42 
X-CRM114-Status: GOOD (  18.74  )
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

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2025 will be held March 24–26, 2025
at the Delta hotel Montreal

LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline
kernel within the coming years.

LSF/MM/BPF 2025 will be a three day, stand-alone conference with
four subsystem-specific tracks, cross-track discussions, as well
as BoF and hacking sessions:

          https://events.linuxfoundation.org/lsfmmbpf/

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please
point that out in your proposal or request to attend, and submit
the topic as soon as possible.

We are asking that you please let us know you want to be invited
by Feb 1st 2025. We realize that travel is an ever changing target,
but it helps us to get an idea of possible attendance numbers.
Clearly things can and will change, so consider the request to
attend deadline more about planning and less about concrete plans.

We are still looking to arrange / fund a virtual component for one
or more of the tracks. We will follow up on the final decision soon
hopefuly. Please note that it is possible that we might not have
virtual attendees option this time.

1) Fill out the following Google form to request attendance and
suggest any topics for discussion:

	  https://forms.gle/xXvQicSFeFKjayxB9

In previous years we have accidentally missed people's attendance
requests because they either did not Cc lsf-pc@ or we simply missed
them in the flurry of emails we get. Our community is large and our
volunteers are busy, filling this out will help us to make sure we
do not miss anybody.

2) Proposals for agenda topics should ideally still be sent to the
following lists to allow for discussion among your peers. This will
help us figure out which topics are important for the agenda:

          lsf-pc@lists.linux-foundation.org

... and Cc the mailing lists that are relevant for the topic in
question:

          FS:     linux-fsdevel@vger.kernel.org
          MM:     linux-mm@kvack.org
          Block:  linux-block@vger.kernel.org
          ATA:    linux-ide@vger.kernel.org
          SCSI:   linux-scsi@vger.kernel.org
          NVMe:   linux-nvme@lists.infradead.org
          BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier
to track. In addition, please make sure to start a new thread for
each topic rather than following up to an existing one. Agenda
topics and attendees will be selected by the program committee,
but the final agenda will be formed by consensus of the attendees
on the day.

3) Like previous years we would also like to try and make sure we are
including new members in the community that the program committee
may not be familiar with. The Google form has an area for people to
add required/optional attendees. Please encourage new members of the
community to submit a request for an invite as well, but additionally
if maintainers or long term community members could add nominees to
the form it would help us make sure that new members get the proper
consideration.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks in order for sessions to be
productive; the sessions are supposed to be interactive, inclusive
discussions.

We are still looking into the virtual component. We will likely run
something similar to what we did last year, but details on that will
be forthcoming.

2024: https://lwn.net/Articles/lsfmmbpf2024/

2023: https://lwn.net/Articles/lsfmmbpf2023/

2022: https://lwn.net/Articles/lsfmm2022/

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

4) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

          lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

          Christian Brauner (Filesystems)
          Jan Kara (Filesystems)
          Martin K. Petersen (Storage)
          Javier González (Storage)
          Michal Hocko (MM)
          Dan Williams (MM)
          Daniel Borkmann (BPF)
          Martin KaFai Lau (BPF)

-- 
Michal Hocko
SUSE Labs

