From: agrover@redhat.com (Andy Grover)
Date: Wed, 12 Oct 2016 17:00:39 -0700
Subject: [PATCH 0/3] nvmetcli fixes
Message-ID: <1476316842-23718-1-git-send-email-agrover@redhat.com>

Here are some small fixes that help packaging nvmetcli,
and help it minimally work with Python 3 -- there are likely more
Py2/3 issues that will come out in testing but this gets us past
initial import errors.

Thanks -- Andy

Andy Grover (3):
  Add nvmetcli to setup.py scripts
  Use relative import in nvmet/__init__.py
  nvmetcli: Fix nvmet import

 nvmet/__init__.py | 2 +-
 nvmetcli          | 2 +-
 setup.py          | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4
