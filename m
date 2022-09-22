Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705A1C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yU26Qt2PCpBQu+bVI9RnI0+6tkQx21KPs3IdXAh6GEU=; b=NI++HU+OS+B2drr8o4pX2bn21p
	Ej9Vw9+OlqL04OSr175b1WpjQMCLu8Vt/TMD16G6UAC6dWczTbgZlQZ6d1E9VugitYHjYtuB4ytV1
	vf2EHm+xEWG6L4uZBw44qbkMAU7hYYIW0mUIXjy2AygK8uG7cYXPUdeGNgCAClIszFHrOmP4oFD6w
	MHVm5ogTdzhbbYQa8aLcgLZ8OXGSV5YBrILyDa0HFSaHdyLC+eJQSprVuecpGn77M9eFduAL91n45
	2hneC1gWQdA/2CdDDPZujbXqr+NsX5rLY8nlMoCiBWAisefHye4WAjpsziziPi7KjsUAmda8S76qO
	Pc7/RkiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obOGp-00GUEY-Rj; Thu, 22 Sep 2022 15:37:47 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obOGm-00GUCr-Pk
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:37:46 +0000
Received: by mail-wr1-x42d.google.com with SMTP id n12so16144906wrx.9
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=yU26Qt2PCpBQu+bVI9RnI0+6tkQx21KPs3IdXAh6GEU=;
        b=RbsjDHhddjRwga/jr3ElW+ArF1IGeIqZIkv2wPMHBS1EH1DCzmjvCZFwhFpy2XHWqr
         7JyGeoLiBfXa4Jr/D1DRUJguLrFKQiwpoqEKG6s5hSANc9D2ulJqywz2MXxylKMJyh1u
         bb9nSff1zsQx/97IdZSlqT3uLf6Y32mPKRUBc6CwCOMv62WDlQUXYi2jBsz3fLpm8bUe
         z6WAjUo1Bg/W9yg4Ct+YKAOFcG2imPOaDa2q+1X7mRp9oPN5SgC6iVop+PBKWqj2WE/h
         Ph4BSCIMVn4iDI+nnCy2R4vZ8l8q+XRbeM/nm/6sNmhk74IDsu/saoliLmQz8oHwLWno
         57xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yU26Qt2PCpBQu+bVI9RnI0+6tkQx21KPs3IdXAh6GEU=;
        b=6VPa1XHTKDvi4JFIUq+bGvxEWsssFwwEX2W75nnju7rG/lGUfc8vPGNTwAKFGwxTun
         smHX1AIXMPIirScHC/qqdHeZc/Sbvy5dOqo9NxNcBwhGVFtunZgmZF9+IhoT34Z7xyIO
         ZENu3ESlQFu9IK6ZLClF4uvVXaGuCUSUdGSnuiUI2L71pRXjvnPK5o7WQwnvg5mHk3c1
         Wrhg1urd/Xim2FGs/m2uHzkXLqBYvH+5rs0lWa5+Uzeea0aIsk1mmcivxf7Ieh3p5usr
         Y1wxKJOwR3Rw6pkE3s6ayB398mwJhQp7xWwwUtwvjmcLFKf2qokpMxyqXwbgIzCJHje1
         nmTA==
X-Gm-Message-State: ACrzQf14gIUNlHCpVIBaZrLtXrtxKeQEgI+al0TAPzPgsQMNcQfRpzg4
	AK0sNT1uA0Wrnf/wmSOvNVfIMWO8tiPfiHt1yQwQcGWCGSZxpcV9
X-Google-Smtp-Source: AMsMyM50fpveg7oAyxbNNkwkBA7o8Sgy1HBTPqQctuFR3dHWOfIMkoyMykueZr7lGFDhdYC3sPJnuUIXSGGIigFSLZo=
X-Received: by 2002:adf:f804:0:b0:228:62fd:6e9a with SMTP id
 s4-20020adff804000000b0022862fd6e9amr2484964wrp.697.1663861061156; Thu, 22
 Sep 2022 08:37:41 -0700 (PDT)
MIME-Version: 1.0
From: Nick Neumann <nick@pcpartpicker.com>
Date: Thu, 22 Sep 2022 10:37:29 -0500
Message-ID: <CADqNVToq+rxkZTmagWcW5s2g+pVpfwBX17wS6C4xm6wszHkGTA@mail.gmail.com>
Subject: nvme smart-log intermittently corrupt from family of SSDs
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_083744_861553_A83263D2 
X-CRM114-Status: UNSURE (   7.06  )
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

I noticed something odd with the smart data from various sized HP
FX900 Pro SSDs. Intermittently, after hours of use, host_writes would
be 0 (but data_units_written would not). After experimenting, I'm
seeing that intermittently, when running either "smartctl -x" or "nvme
smart-log", the data coming back is, uh, junk?

sudo nvme smart-log /dev/nvme0n1
Smart Log for NVME device:nvme0n1 namespace-id:ffffffff
critical_warning                    : 0
temperature                         : 48 C
available_spare                     : 100%
available_spare_threshold           : 25%
percentage_used                     : 0%
data_units_read                     : 793353
data_units_written                  : 4938926
host_read_commands                  : 18675956
host_write_commands                 : 40381344
controller_busy_time                : 0
power_cycles                        : 9
power_on_hours                      : 15
unsafe_shutdowns                    : 1
media_errors                        : 0
num_err_log_entries                 : 217026295083295649698117473405925064704
Warning Temperature Time            : 1323299686
Critical Composite Temperature Time : 4108885430
Temperature Sensor 1                : 38041 C
Temperature Sensor 2                : 55225 C
Temperature Sensor 3                : 23326 C
Temperature Sensor 4                : 38685 C
Temperature Sensor 5                : 57125 C
Temperature Sensor 6                : 45486 C
Temperature Sensor 7                : 59856 C
Temperature Sensor 8                : 2107 C
Thermal Management T1 Trans Count   : 1702871148
Thermal Management T2 Trans Count   : 312071619
Thermal Management T1 Total Time    : 406823074
Thermal Management T2 Total Time    : 468107429

Even odder, when the host_write_commands was 0, the rest of the data
was sane. So the incorrectness is not always obvious...

Any recommendations or thoughts on dealing with this? Or am I just out
of luck when it comes to relying on anything from these drives' smart
logs?

