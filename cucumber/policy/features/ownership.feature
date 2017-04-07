Feature: Custom ownership can be assigned to a policy object.

  By default, each object in a policy is owned by the policy.
  This means that the policy role has full admin rights to the objects within
  it.

  However, ownership of each object can be assigned to a role other than the
  policy.

  Scenario: The default owner of a policy-scoped object is the policy.
    Given a policy:
    """
    - !user bob

    - !policy
      id: db
      body:
      - !variable password
    """
    Then the owner of variable "db/password" is policy "db"

  Scenario: The owner of a policy-scoped object can be changed.
    Given a policy:
    """
    - !group secrets-managers

    - !variable
      id: password
      owner: !group secrets-managers
    """
    Then the owner of variable "password" is group "secrets-managers"