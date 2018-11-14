From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Nov 2018 16:14:17 +0100
Subject: [PATCHv2] nvmetcli: ANA configuration support
In-Reply-To: <20181108122736.76270-1-hare@suse.de>
References: <20181108122736.76270-1-hare@suse.de>
Message-ID: <20181114151417.GA28175@lst.de>

This fails to restore a config that doesn't have the ANA fields
yet (actual config attached):

Traceback (most recent call last):
  File "./nvmetcli", line 740, in <module>
    main()
  File "./nvmetcli", line 722, in main
    funcs[sys.argv[1]](savefile)
  File "./nvmetcli", line 678, in restore
    errors = nvme.Root().restore_from_file(from_file)
  File "/root/nvmetcli/nvmet/nvme.py", line 382, in restore_from_file
    abort_on_error=abort_on_error)
  File "/root/nvmetcli/nvmet/nvme.py", line 356, in restore
    Subsystem.setup(t, err_func)
  File "/root/nvmetcli/nvmet/nvme.py", line 497, in setup
    Namespace.setup(s, ns, err_func)
  File "/root/nvmetcli/nvmet/nvme.py", line 610, in setup
    ns.set_grpid(int(n['ana_grpid']))
KeyError: 'ana_grpid'
-------------- next part --------------
A non-text attachment was scrubbed...
Name: loop2.json
Type: application/json
Size: 1221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181114/aaa1f9c0/attachment.json>
