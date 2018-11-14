From: hare@suse.com (Hannes Reinecke)
Date: Wed, 14 Nov 2018 16:23:08 +0100
Subject: [PATCHv2] nvmetcli: ANA configuration support
In-Reply-To: <20181114151417.GA28175@lst.de>
References: <20181108122736.76270-1-hare@suse.de>
 <20181114151417.GA28175@lst.de>
Message-ID: <88f6608b-df3c-2528-4f9c-1e4610fabf44@suse.com>

On 11/14/18 4:14 PM, Christoph Hellwig wrote:
> This fails to restore a config that doesn't have the ANA fields
> yet (actual config attached):
> 
> Traceback (most recent call last):
>    File "./nvmetcli", line 740, in <module>
>      main()
>    File "./nvmetcli", line 722, in main
>      funcs[sys.argv[1]](savefile)
>    File "./nvmetcli", line 678, in restore
>      errors = nvme.Root().restore_from_file(from_file)
>    File "/root/nvmetcli/nvmet/nvme.py", line 382, in restore_from_file
>      abort_on_error=abort_on_error)
>    File "/root/nvmetcli/nvmet/nvme.py", line 356, in restore
>      Subsystem.setup(t, err_func)
>    File "/root/nvmetcli/nvmet/nvme.py", line 497, in setup
>      Namespace.setup(s, ns, err_func)
>    File "/root/nvmetcli/nvmet/nvme.py", line 610, in setup
>      ns.set_grpid(int(n['ana_grpid']))
> KeyError: 'ana_grpid'
> 
Gnaa. My python skills are crap.

Will see to have it fixed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
