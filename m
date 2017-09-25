From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Sep 2017 16:22:53 +0300
Subject: [PATCH rfc] nvme-cli: NVMf auto discovery systemd service
In-Reply-To: <20170925075517.3kpbkj3snig35hb2@linux-x5ow.site>
References: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
 <20170925075517.3kpbkj3snig35hb2@linux-x5ow.site>
Message-ID: <ec56b6fa-89b0-6646-6618-1e857b234349@grimberg.me>


>> +        if [ ! -f /etc/nvme/discovery.conf ]; then
>> +		touch /etc/nvme/discovery.conf
>> +        fi
> 
> I don't think having an empty discovery.conf is a particularly good idea, the
> contents should be either added by hand or by some configuration/installer
> tool (YAST, Anaconda, Chef, Puppet, yada yada).

Its just placing the file there to not fail the service by definition of
the conf not being there - if its empty it just silently exits. We can
skip it if you think its not a good idea.

>> +# NVMf auto-discovery service
>> +install -m 0755 systemd/nvmf-discovery.service /lib/systemd/system/
>> +systemctl enable nvmf-discovery.service
> 
> Unconditionally starting services will is (at least for SUSE RPMs) a no-go.

OK, we can lose it.

>> +
>> +# we rely on /dev/nvme-fabrics misc device, so auto load nvme-fabrics
>> +# at boot time
>> +echo nvme-fabrics >> /etc/modules-load.d/modules.conf
> 
> This should be done in the systemd unit file I think. Something like this:
> 
>> diff --git a/systemd/nvmf-discovery.service b/systemd/nvmf-discovery.service
>> new file mode 100644
>> index 000000000000..25f7bf1f077b
>> --- /dev/null
>> +++ b/systemd/nvmf-discovery.service
>> @@ -0,0 +1,12 @@
>> +[Unit]
>> +Description=NVMf auto discovery service
>> +After=systemd-modules-load.service network-online.target
>> +
>> +[Service]
>> +Type=oneshot
> 
> ExecStartPre=-/sbin/modprobe nvme-fabrics

looks better!
