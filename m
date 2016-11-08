From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 8 Nov 2016 12:31:07 +0200
Subject: [PATCH RFC nvme-cli 2/2] nvme.spec: generate hostnqn file on
 install and remove on uninstall
In-Reply-To: <20161107083639.naen6aolbogpe2ic@linux-x5ow.site>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <1478459581-22654-3-git-send-email-sagi@grimberg.me>
 <20161107083639.naen6aolbogpe2ic@linux-x5ow.site>
Message-ID: <3e1f41d7-e518-da7d-b561-2e17ca622a8b@grimberg.me>


> Two things, a) are you sure this is correct? I interpret $year_month as year
> and month, not year and day (date | awk '{print $6"-"$3}' evaluates to 2016-7
> here) and b) 'date +"%Y-%m"' saves you a 2nd process.

Thanks for the tip... I'm moving it to nvme utility though.

Cheers,
Sagi.
