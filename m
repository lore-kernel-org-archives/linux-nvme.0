From: robert.r.randall@gmail.com (Robert Randall)
Date: Fri, 29 Jul 2016 07:33:46 -0500
Subject: any udev rules for nvme devices - hosts don't always get the correct
 namespace(s)
Message-ID: <CAEqzOjuBERv8Vahh0k-_CAkmWvOpwKqySHZxjL+3z6Ma5hKGfQ@mail.gmail.com>

I'm working with a server with 4 NVMe SSDs which tend to be swapped
out from time to time.  I noticed that I can't find any udev rules for
uniquely identifying nvme devices.  Are they out there somewhere
already?  If so, in which repository or package?

This is the typical problem of providing a guaranteed mapping of
device to device node so that NVMeOF hosts are guaranteed to always
connect to the correct device.

For example, from a json file used with nvmetcli:

      "namespaces": [
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
          "nsid": 1
        },
        {
          "device": {
            "nguid": "00000000-0000-0000-0000-000000000000",
            "path": "/dev/nvme1n1"
          },
          "enable": 1,
          "nsid": 2
        }
      ],
      "nqn": "zuul_win"

The "path" above is not a guarantee that the correct device will
always be mapped to the expected namespace.  The device nodes will
change when cards are add / removed / moved in the system from one bus
slot to another.

Happy to dig in and write some if you can point me to the official
rules to follow for creating a udev rules package.  I've not created
one for many years.

Best regards,
Robert

-- 
Robert Randall | robert.r.randall at gmail.com
