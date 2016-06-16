From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 16 Jun 2016 15:01:35 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <5763044A.9090206@grimberg.me>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
Message-ID: <01b701d1c809$e2b4b6d0$a81e2470$@opengridcomputing.com>

> Umm, I think this might be happening because we get to delete_ctrl when
> one of our queues has a NULL ctrl. This means that either:
> 1. we never got a chance to initialize it, or
> 2. we already freed it.
> 
> (1) doesn't seem possible as we have a very short window (that we're
> better off eliminating) between when we start the keep-alive timer (in
> alloc_ctrl) and the time we assign the sq->ctrl (install_queue).
> 
> (2) doesn't seem likely either to me at least as from what I followed,
> delete_ctrl should be mutual exclusive with other deletions, moreover,
> I didn't see an indication in the logs that any other deletions are
> happening.
> 
> Steve, is this something that started happening recently? does the
> 4.6-rc3 tag suffer from the same phenomenon?

In case it matters, here is my target config file.  I'm only connecting to 1
device (test-hynix0).  But each device is exported over 2 ports of a Chelsio
iWARP T580, and 1 port of a MLX IB mlx4 QDR adapter.

[root at stevo2 ~]# cat /etc/nvmet.json
{
  "hosts": [],
  "ports": [
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "10.0.1.14",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "rdma"
      },
      "portid": 1,
      "referrals": [],
      "subsystems": [
        "test-ram0",
        "test-ram1",
        "test-ram2",
        "test-ram3",
        "test-hynix0",
        "test-nullb0",
        "test-nullb1"
      ]
    },
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "10.0.2.14",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "rdma"
      },
      "portid": 2,
      "referrals": [],
      "subsystems": [
        "test-ram0",
        "test-ram1",
        "test-ram2",
        "test-ram3",
        "test-hynix0",
        "test-nullb0",
        "test-nullb1"
      ]
    },
    {
      "addr": {
        "adrfam": "ipv4",
        "traddr": "10.0.7.14",
        "treq": "not specified",
        "trsvcid": "4420",
        "trtype": "rdma"
      },
      "portid": 7,
      "referrals": [],
      "subsystems": [
        "test-ram0",
        "test-ram1",
        "test-ram2",
        "test-ram3",
        "test-hynix0",
        "test-nullb0",
        "test-nullb1"
      ]
    }
  ],
  "subsystems": [
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-123400000000",
            "path": "/dev/ram0"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-ram0"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-567800000000",
            "path": "/dev/ram1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-ram1"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-9abc00000000",
            "path": "/dev/ram2"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-ram2"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-def100000000",
            "path": "/dev/ram3"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-ram3"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "5aa133f4-7c41-f141-b469-901e58461e7b",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-hynix0"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "569232db-0f5a-8d4f-a077-7935117e2f3f",
            "path": "/dev/nullb0"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-nullb0"
    },
    {
      "allowed_hosts": [],
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "9eb7de4b-3ee9-4641-a6e3-e2569414e5a0",
            "path": "/dev/nullb1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],
      "nqn": "test-nullb1"
    }
  ]
}
